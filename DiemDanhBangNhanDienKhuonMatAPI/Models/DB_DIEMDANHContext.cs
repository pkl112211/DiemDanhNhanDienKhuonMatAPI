using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.Extensions.Configuration;

namespace DiemDanhBangNhanDienKhuonMatAPI.Models
{
    public partial class DB_DIEMDANHContext : DbContext
    {
        public DB_DIEMDANHContext()
        {
        }

        public DB_DIEMDANHContext(DbContextOptions<DB_DIEMDANHContext> options)
            : base(options)
        {
        }

        public virtual DbSet<ChiTietDiemDanh> ChiTietDiemDanh { get; set; }
        public virtual DbSet<ChiTietNgayHoc> ChiTietNgayHoc { get; set; }
        public virtual DbSet<GiangVien> GiangVien { get; set; }
        public virtual DbSet<LopHoc> LopHoc { get; set; }
        public virtual DbSet<MonHoc> MonHoc { get; set; }
        public virtual DbSet<SinhVien> SinhVien { get; set; }
        public virtual DbSet<SinhVienTrongLopHoc> SinhVienTrongLopHoc { get; set; }
        public virtual DbSet<ThongBao> ThongBao { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer(new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["DB_DIEMDANH"]);
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ChiTietDiemDanh>(entity =>
            {
                entity.HasIndex(e => new { e.IdchiTietNgayHoc, e.IdsinhVienTrongLopHoc })
                    .HasName("UQ__ChiTietD__A74B4C12F3DA21C7")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.IdchiTietNgayHoc).HasColumnName("IDChiTietNgayHoc");

                entity.Property(e => e.IdsinhVienTrongLopHoc).HasColumnName("IDSinhVienTrongLopHoc");

                entity.Property(e => e.IsDiemDanh).HasColumnName("isDiemDanh");

                entity.HasOne(d => d.IdchiTietNgayHocNavigation)
                    .WithMany(p => p.ChiTietDiemDanh)
                    .HasForeignKey(d => d.IdchiTietNgayHoc)
                    .HasConstraintName("FK__ChiTietDi__IDChi__300424B4");

                entity.HasOne(d => d.IdsinhVienTrongLopHocNavigation)
                    .WithMany(p => p.ChiTietDiemDanh)
                    .HasForeignKey(d => d.IdsinhVienTrongLopHoc)
                    .HasConstraintName("FK__ChiTietDi__IDSin__30F848ED");
            });

            modelBuilder.Entity<ChiTietNgayHoc>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.IdlopHoc).HasColumnName("IDLopHoc");

                entity.Property(e => e.PhongHoc)
                    .IsRequired()
                    .HasColumnName("phongHoc")
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.ThoiGianBatDauBuoiHoc)
                    .HasColumnName("thoiGianBatDauBuoiHoc")
                    .HasColumnType("smalldatetime");

                entity.HasOne(d => d.IdlopHocNavigation)
                    .WithMany(p => p.ChiTietNgayHoc)
                    .HasForeignKey(d => d.IdlopHoc)
                    .HasConstraintName("FK__ChiTietNg__IDLop__31EC6D26");
            });

            modelBuilder.Entity<GiangVien>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.DiaChi)
                    .HasColumnName("diaChi")
                    .HasMaxLength(100);

                entity.Property(e => e.Email)
                    .HasColumnName("email")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.GhiChu).HasColumnName("ghiChu");

                entity.Property(e => e.GioiTinh).HasColumnName("gioiTinh");

                entity.Property(e => e.HoTen)
                    .IsRequired()
                    .HasColumnName("hoTen")
                    .HasMaxLength(100);

                entity.Property(e => e.MatKhau)
                    .IsRequired()
                    .HasColumnName("matKhau")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Msgv)
                    .HasColumnName("MSGV")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasComputedColumnSql("('GV'+right('00000000'+CONVERT([varchar](8),[ID]),(8)))");

                entity.Property(e => e.NgaySinh)
                    .HasColumnName("ngaySinh")
                    .HasColumnType("date");

                entity.Property(e => e.SoDienThoai)
                    .HasColumnName("soDienThoai")
                    .HasMaxLength(15)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<LopHoc>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.IdgiangVien).HasColumnName("IDGiangVien");

                entity.Property(e => e.IdmonHoc).HasColumnName("IDMonHoc");

                entity.HasOne(d => d.IdgiangVienNavigation)
                    .WithMany(p => p.LopHoc)
                    .HasForeignKey(d => d.IdgiangVien)
                    .HasConstraintName("FK__LopHoc__IDGiangV__32E0915F");

                entity.HasOne(d => d.IdmonHocNavigation)
                    .WithMany(p => p.LopHoc)
                    .HasForeignKey(d => d.IdmonHoc)
                    .HasConstraintName("FK__LopHoc__IDMonHoc__33D4B598");
            });

            modelBuilder.Entity<MonHoc>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.TenMonHoc)
                    .IsRequired()
                    .HasColumnName("tenMonHoc")
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<SinhVien>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.DiaChi)
                    .HasColumnName("diaChi")
                    .HasMaxLength(100);

                entity.Property(e => e.Email)
                    .HasColumnName("email")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.GhiChu).HasColumnName("ghiChu");

                entity.Property(e => e.GioiTinh).HasColumnName("gioiTinh");

                entity.Property(e => e.HasRegisteredFace).HasColumnName("hasRegisteredFace");

                entity.Property(e => e.HoTen)
                    .IsRequired()
                    .HasColumnName("hoTen")
                    .HasMaxLength(100);

                entity.Property(e => e.MatKhau)
                    .IsRequired()
                    .HasColumnName("matKhau")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Mssv)
                    .HasColumnName("MSSV")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasComputedColumnSql("('SV'+right('00000000'+CONVERT([varchar](8),[ID]),(8)))");

                entity.Property(e => e.NgaySinh)
                    .HasColumnName("ngaySinh")
                    .HasColumnType("date");

                entity.Property(e => e.SoDienThoai)
                    .HasColumnName("soDienThoai")
                    .HasMaxLength(15)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<SinhVienTrongLopHoc>(entity =>
            {
                entity.HasIndex(e => new { e.IdlopHoc, e.IdsinhVien })
                    .HasName("UQ__SinhVien__F275A50165F00B8D")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.IdlopHoc).HasColumnName("IDLopHoc");

                entity.Property(e => e.IdsinhVien).HasColumnName("IDSinhVien");

                entity.HasOne(d => d.IdlopHocNavigation)
                    .WithMany(p => p.SinhVienTrongLopHoc)
                    .HasForeignKey(d => d.IdlopHoc)
                    .HasConstraintName("FK__SinhVienT__IDLop__34C8D9D1");

                entity.HasOne(d => d.IdsinhVienNavigation)
                    .WithMany(p => p.SinhVienTrongLopHoc)
                    .HasForeignKey(d => d.IdsinhVien)
                    .HasConstraintName("FK__SinhVienT__IDSin__35BCFE0A");
            });

            modelBuilder.Entity<ThongBao>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.IdlopHoc).HasColumnName("IDLopHoc");

                entity.Property(e => e.NgayTao)
                    .HasColumnName("ngayTao")
                    .HasColumnType("smalldatetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.NoiDung)
                    .IsRequired()
                    .HasColumnName("noiDung");

                entity.Property(e => e.TieuDe)
                    .IsRequired()
                    .HasColumnName("tieuDe");

                entity.HasOne(d => d.IdlopHocNavigation)
                    .WithMany(p => p.ThongBao)
                    .HasForeignKey(d => d.IdlopHoc)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__ThongBao__IDLopH__6FE99F9F");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
