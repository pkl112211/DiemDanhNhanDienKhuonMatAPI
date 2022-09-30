using Microsoft.Azure.CognitiveServices.Vision.Face;
using Microsoft.Azure.CognitiveServices.Vision.Face.Models;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DiemDanhBangNhanDienKhuonMatAPI.Services
{
    public class MSCognitionService
    {
        public class DetectedPerson
        {
            public string ExternalID { set; get; }
            public double Confidence { set; get; }

            public DetectedPerson(string externalID, double confidence)
            {
                this.ExternalID = externalID;
                this.Confidence = confidence;
            }

        }


        static string API_KEY = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("MSCognition")["apiKey"];
        static string END_POINT = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("MSCognition")["endPoint"];



        const string RECOGNITION_MODEL1 = RecognitionModel.Recognition01;
        static string groupID = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("MSCognition")["groupID"];


        public static IFaceClient client;

        public static void CreateClient()
        {
            client = new FaceClient(new ApiKeyServiceClientCredentials(API_KEY)) { Endpoint = END_POINT };
        }

        public static async Task<string> CreateAGroupAsync(string name)
        {
            // Create a person group. 
            string personGroupId = Guid.NewGuid().ToString();

            Console.WriteLine($"Create a person group ({personGroupId}).");
            await client.PersonGroup.CreateAsync(personGroupId, name: name, recognitionModel: RECOGNITION_MODEL1);
            return personGroupId;
        }




        public static async Task AddNewPerson(string personExternalID, string[] lstImageURLs)
        {
            Person person = await client.PersonGroupPerson.CreateAsync(personGroupId: groupID, name: personExternalID);
            Console.WriteLine($"Create a person group person '{personExternalID}'.");

            // Add face to the person group person.
            foreach (var imageURL in lstImageURLs)
            {
                try
                {
                    Console.WriteLine($"Add face to the person group person({personExternalID}) from image `{imageURL}`");
                    PersistedFace face = await client.PersonGroupPerson.AddFaceFromUrlAsync(groupID, person.PersonId,
                        imageURL, imageURL);
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            }


            // Start to train the person group.
            Console.WriteLine();
            Console.WriteLine($"Train person group {groupID}.");
            await client.PersonGroup.TrainAsync(groupID);

            // Wait until the training is completed.
            while (true)
            {
                Console.WriteLine("Please Wait...");
                await Task.Delay(1000);
                var trainingStatus = await client.PersonGroup.GetTrainingStatusAsync(groupID);
                Console.WriteLine($"Training status: {trainingStatus.Status}.");
                if (trainingStatus.Status == TrainingStatusType.Succeeded) { break; }
            }
        }


        public static async Task UpdatePersonFace(string personExternalID, string[] lstImageURLs)
        {
            Person person = null;
            var lstPerson = await client.PersonGroupPerson.ListAsync(groupID);
            foreach (var p in lstPerson)
            {
                if (p.Name.Equals(personExternalID))
                {
                    person = p;
                    break;
                }
            }
            if (person == null)
                return;

            await client.PersonGroupPerson.DeleteAsync(groupID, person.PersonId);
            await AddNewPerson(personExternalID, lstImageURLs);


            //Person person = null;


            //var lstPerson = await client.PersonGroupPerson.ListAsync(groupID);
            //foreach (var p in lstPerson)
            //{
            //    if (p.Name.Equals(personExternalID))
            //    {
            //        person = p;
            //        break;
            //    }
            //}

            //if (person == null)
            //    return;

            //Console.WriteLine($"Update person: '{personExternalID}'.");

            //// Add face to the person group person.
            //foreach (var imageURL in lstImageURLs)
            //{
            //    try
            //    {
            //        Console.WriteLine($"Add face to the person group person({personExternalID}) from image `{imageURL}`");
            //        PersistedFace face = await client.PersonGroupPerson.AddFaceFromUrlAsync(groupID, person.PersonId,
            //            imageURL, imageURL);
            //    }
            //    catch (Exception e)
            //    {
            //        Console.WriteLine(e.Message);
            //    }
            //}


            //// Start to train the person group.
            //Console.WriteLine();
            //Console.WriteLine($"Train person group {groupID}.");
            //await client.PersonGroup.TrainAsync(groupID);

            //// Wait until the training is completed.
            //while (true)
            //{
            //    Console.WriteLine("Please Wait...");
            //    await Task.Delay(1000);
            //    var trainingStatus = await client.PersonGroup.GetTrainingStatusAsync(groupID);
            //    Console.WriteLine($"Training status: {trainingStatus.Status}.");
            //    if (trainingStatus.Status == TrainingStatusType.Succeeded) { break; }
            //}
        }


        public static async Task<List<DetectedPerson>> IdentityAFaceAsync(string imageURL)
        {

            List<DetectedPerson> lstExternalID = new List<DetectedPerson>(); //result

            List<Guid> sourceFaceIds = new List<Guid>(); // LIST này để đựng khuôn mặt Detect được trong ảnh truyền vào
            // Detect faces from source image url.
            List<DetectedFace> detectedFaces = null;
            IList<IdentifyResult> identifyResults = null;
            try
            {
                detectedFaces = await DetectFaceRecognize(client, $"{imageURL}", RECOGNITION_MODEL1);

                // Add detected faceId to sourceFaceIds.
                foreach (var detectedFace in detectedFaces) { sourceFaceIds.Add(detectedFace.FaceId.Value); }

                // Identify the faces in a person group. 
                identifyResults = await client.Face.IdentifyAsync(sourceFaceIds, groupID); //bỏ danh sách khuôn mặt tìm được trong ảnh truyền vào và nhận diện
            }
            catch (Exception e)
            {
                return lstExternalID;
            }


            foreach (var identifyResult in identifyResults)
            {
                try
                {
                    Person person = await client.PersonGroupPerson.GetAsync(groupID, identifyResult.Candidates[0].PersonId);


                    Console.WriteLine($"Person '{person.Name}' is identified for face in: {imageURL} - {identifyResult.FaceId}," +
                       $" confidence: {identifyResult.Candidates[0].Confidence}.");

                    string externalID = person.Name;
                    double confidence = identifyResult.Candidates[0].Confidence;
                    var temp = new DetectedPerson(externalID, confidence);
                    lstExternalID.Add(temp);
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }



            }

            return lstExternalID;

        }



        public static async Task<bool> AddNewPersonFromStream(string personExternalID, string[] lstBase64String)
        {

            Person person = await client.PersonGroupPerson.CreateAsync(personGroupId: groupID, name: personExternalID);
            Console.WriteLine($"Create a person group person '{personExternalID}'.");

            // Add face to the person group person.
            foreach (var base64String in lstBase64String)
            {
                try
                {
                    Console.WriteLine($"Add face to the person group person({personExternalID}) from image `{base64String}`");
                    PersistedFace face = await client.PersonGroupPerson.AddFaceFromStreamAsync(groupID, person.PersonId, Base64ToStream(base64String));
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    return false;
                }
            }


            // Start to train the person group.
            Console.WriteLine();
            Console.WriteLine($"Train person group {groupID}.");
            await client.PersonGroup.TrainAsync(groupID);

            // Wait until the training is completed.
            while (true)
            {
                Console.WriteLine("Please Wait...");
                await Task.Delay(1000);
                var trainingStatus = await client.PersonGroup.GetTrainingStatusAsync(groupID);
                Console.WriteLine($"Training status: {trainingStatus.Status}.");
                if (trainingStatus.Status == TrainingStatusType.Succeeded) { break; }
            }
            return true;
        }

        public static async Task<bool> UpdatePersonFaceFromStream(string personExternalID, string[] lstBase64String)
        {
            Person person = null;
            var lstPerson = await client.PersonGroupPerson.ListAsync(groupID);
            foreach (var p in lstPerson)
            {
                if (p.Name.Equals(personExternalID))
                {
                    person = p;
                    break;
                }
            }
            if (person == null)
                return false;

            await client.PersonGroupPerson.DeleteAsync(groupID, person.PersonId);
            if(await AddNewPersonFromStream(personExternalID, lstBase64String))
                return true;
            return false;

            //Person person = null;


            //var lstPerson = await client.PersonGroupPerson.ListAsync(groupID);
            //foreach (var p in lstPerson)
            //{
            //    if (p.Name.Equals(personExternalID))
            //    {
            //        person = p;
            //        break;
            //    }
            //}

            //if (person == null)
            //    return;

            //Console.WriteLine($"Update person: '{personExternalID}'.");


            //// Add face to the person group person.
            //foreach (var base64String in lstBase64String)
            //{
            //    try
            //    {
            //        Console.WriteLine($"Add face to the person group person({personExternalID}) from image `{base64String}`");
            //        PersistedFace face = await client.PersonGroupPerson.AddFaceFromStreamAsync(groupID, person.PersonId, Base64ToStream(base64String));
            //    }
            //    catch (Exception e)
            //    {
            //        Console.WriteLine(e.Message);
            //    }
            //}


            //// Start to train the person group.
            //Console.WriteLine();
            //Console.WriteLine($"Train person group {groupID}.");
            //await client.PersonGroup.TrainAsync(groupID);

            //// Wait until the training is completed.
            //while (true)
            //{
            //    Console.WriteLine("Please Wait...");
            //    await Task.Delay(1000);
            //    var trainingStatus = await client.PersonGroup.GetTrainingStatusAsync(groupID);
            //    Console.WriteLine($"Training status: {trainingStatus.Status}.");
            //    if (trainingStatus.Status == TrainingStatusType.Succeeded) { break; }
            //}
        }

        public static async Task<List<DetectedPerson>> IdentityAFaceAsyncFromStream(string base64String)
        {

            List<DetectedPerson> lstExternalID = new List<DetectedPerson>(); //result

            List<Guid> sourceFaceIds = new List<Guid>(); // LIST này để đựng khuôn mặt Detect được trong ảnh truyền vào
            // Detect faces from source image url.
            List<DetectedFace> detectedFaces = await DetectFaceRecognizeStream(client, base64String, RECOGNITION_MODEL1);

            // Add detected faceId to sourceFaceIds.
            foreach (var detectedFace in detectedFaces) { sourceFaceIds.Add(detectedFace.FaceId.Value); }

            // Identify the faces in a person group. 
            var identifyResults = await client.Face.IdentifyAsync(sourceFaceIds, groupID); //bỏ danh sách khuôn mặt tìm được trong ảnh truyền vào và nhận diện

            foreach (var identifyResult in identifyResults)
            {
                try
                {
                    Person person = await client.PersonGroupPerson.GetAsync(groupID, identifyResult.Candidates[0].PersonId);


                    Console.WriteLine($"Person '{person.Name}' is identified for face in: Base64 - {identifyResult.FaceId}," +
                       $" confidence: {identifyResult.Candidates[0].Confidence}.");

                    string externalID = person.Name;
                    double confidence = identifyResult.Candidates[0].Confidence;
                    var temp = new DetectedPerson(externalID, confidence);
                    lstExternalID.Add(temp);
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);

                }



            }

            return lstExternalID;

        }


        public static Stream Base64ToStream(string base64)
        {
            var bytes = Convert.FromBase64String(base64);
            return new MemoryStream(bytes);
        }

        private static async Task<List<DetectedFace>> DetectFaceRecognize(IFaceClient faceClient, string url, string RECOGNITION_MODEL1)
        {
            // Detect faces from image URL. Since only recognizing, use the recognition model 1.
            IList<DetectedFace> detectedFaces = await faceClient.Face.DetectWithUrlAsync(url, recognitionModel: RECOGNITION_MODEL1);
            Console.WriteLine($"{detectedFaces.Count} face(s) detected from image `{Path.GetFileName(url)}`");
            return detectedFaces.ToList();
        }

        private static async Task<List<DetectedFace>> DetectFaceRecognizeStream(IFaceClient faceClient, string base64String, string RECOGNITION_MODEL1)
        {
            // Detect faces from image URL. Since only recognizing, use the recognition model 1.
            IList<DetectedFace> detectedFaces = await faceClient.Face.DetectWithStreamAsync(Base64ToStream(base64String), recognitionModel: RECOGNITION_MODEL1);
            //Console.WriteLine($"{detectedFaces.Count} face(s) detected from image `{Path.GetFileName(url)}`");
            return detectedFaces.ToList();
        }
    }
}
