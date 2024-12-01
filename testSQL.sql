-- Membuat Database dan Skema
CREATE SCHEMA latnewjual;
CREATE DATABASE newjual1;

-- Menampilkan Database
SHOW DATABASES;

-- Membuka Database
USE newjual1;

-- Menghapus Database
DROP DATABASE newjual1;

-- Membuat Tabel Produk
CREATE TABLE produk (
    idproduk CHAR(5) NOT NULL,
    nmproduk VARCHAR(30) NOT NULL,
    satuan VARCHAR(10) NOT NULL,
    harga NUMERIC(10,0) NOT NULL DEFAULT '0',
    stock INT(3) NOT NULL DEFAULT '0',
    PRIMARY KEY(idproduk)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

-- Membuat Tabel Pelanggan
CREATE TABLE pelanggan (
    idpelanggan VARCHAR(5) NOT NULL,
    nm_pelanggan VARCHAR(30) NOT NULL,
    alamat TEXT NOT NULL,
    telepon VARCHAR(15) NOT NULL,
    email VARCHAR(20) NOT NULL,
    PRIMARY KEY(idpelanggan)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

-- Membuat Tabel Pesan
CREATE TABLE pesan (
    idpesan CHAR(8) NOT NULL,
    idpelanggan VARCHAR(5) NOT NULL,
    tglpesan DATE NOT NULL,
    PRIMARY KEY(idpesan),
    KEY FK_pesan(idpelanggan),
    CONSTRAINT FK_pesan FOREIGN KEY (idpelanggan) REFERENCES pelanggan(idpelanggan) ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=latin1;

-- Membuat Tabel Detail Pesan
CREATE TABLE detail_pesan (
    idpesan CHAR(8) NOT NULL,
    idproduk CHAR(5) NOT NULL,
    jumlah INT(5) NOT NULL DEFAULT '0',
    harga NUMERIC(10,0) NOT NULL DEFAULT '0',
    PRIMARY KEY(idpesan, idproduk),
    KEY FK_detail_pesan(idproduk),
    KEY FK_detail_pesan2(idpesan),
    CONSTRAINT FK_detail_pesan FOREIGN KEY (idproduk) REFERENCES produk(idproduk),
    CONSTRAINT FK_detail_pesan2 FOREIGN KEY (idpesan) REFERENCES pesan(idpesan)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

-- Membuat Tabel Faktur
CREATE TABLE faktur (
    id_faktur CHAR(9) NOT NULL,
    idpesan CHAR(8) NOT NULL,
    tgl_faktur DATE NOT NULL,
    PRIMARY KEY (id_faktur),
    KEY FK_faktur (idpesan),
    CONSTRAINT FK_faktur FOREIGN KEY (idpesan) REFERENCES pesan(idpesan)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

-- Membuat Tabel Kuitansi
CREATE TABLE kuitansi (
    id_kuitansi CHAR(5) NOT NULL,
    id_faktur CHAR(9) NOT NULL,
    tgl_kuitansi DATE NOT NULL,
    PRIMARY KEY (id_kuitansi),
    KEY FK_kuitansi (id_faktur),
    CONSTRAINT FK_kuitansi FOREIGN KEY (id_faktur) REFERENCES faktur(id_faktur)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

-- Menambah Baris Data Tabel Pelanggan
INSERT INTO pelanggan VALUES ('PL001', 'FAJAR SADBOY', 'Depok', '08123456789', 'FajarCihuy@gmail.com');
INSERT INTO pelanggan VALUES ('PL002', 'Miftahul', 'Depok', '08123456789', 'punyanyapajar@gmail.com');
INSERT INTO pelanggan VALUES ('PL003', 'Dayat', 'Jakarta', '0811223344', 'yatCihuy@gmail.com');
INSERT INTO pelanggan VALUES ('PL004', 'Han', 'Tangerang', '08115223441', 'wowkeren@gmail.com');
INSERT INTO pelanggan VALUES ('PL005', 'Remi', 'Jakarta', '0811253389', 'Aqua@gmail.com');

-- Menghapus Data Tabel Pelanggan
DELETE FROM pelanggan WHERE idpelanggan = 'PL004';

-- Menambah Baris Data Tabel Produk
INSERT INTO produk VALUES ('BR001', 'Printer Canon', 'unit', 65000, 10);
INSERT INTO produk VALUES ('BR002', 'Notebook Asus 14', 'unit', 500000, 2);
INSERT INTO produk VALUES ('BR003', 'Mouse+keyboard set', 'unit', 180000, 3);
INSERT INTO produk VALUES ('BR004', 'Speaker Simbadda', 'unit', 350000, 4);
INSERT INTO produk VALUES ('BR005', 'Earphone', 'unit', 100000, 5);

-- Menambah Baris Data Tabel Pesan
INSERT INTO pesan VALUES ('PO150401', 'PL004', '2024/04/28');
INSERT INTO pesan VALUES ('PO150402', 'PL002', '2024/04/28');
INSERT INTO pesan VALUES ('PO150403', 'PL001', '2024/04/28');

-- Menambah Baris Data Tabel Detail Pesan
INSERT INTO detail_pesan VALUES ('PO150401', 'BR002', 1, 5000000);
INSERT INTO detail_pesan VALUES ('PO150401', 'BR005', 1, 100000);
INSERT INTO detail_pesan VALUES ('PO150402', 'BR003', 1, 180000);
INSERT INTO detail_pesan VALUES ('PO150402', 'BR005', 1, 100000);
INSERT INTO detail_pesan VALUES ('PO150402', 'BR001', 1, 650000);
INSERT INTO detail_pesan VALUES ('PO150403', 'BR002', 1, 5000000);

-- Menambah Baris Data Tabel Faktur
INSERT INTO faktur VALUES ('F1504001', 'PO150401', '2024/04/28');
INSERT INTO faktur VALUES ('F1504002', 'PO150402', '2024/04/28');
INSERT INTO faktur VALUES ('F1504003', 'PO150403', '2024/04/28');

-- Menambah Baris Data Tabel Kuitansi
INSERT INTO kuitansi VALUES ('K0401', 'F1504001', '2024/04/28');
INSERT INTO kuitansi VALUES ('K0402', 'F1504002', '2024/04/28');
INSERT INTO kuitansi VALUES ('K0403', 'F1504003', '2024/04/28');

-- Menampilkan Data
SELECT * FROM pelanggan;
SELECT * FROM pesan;
SELECT * FROM produk;
SELECT * FROM detail_pesan;
SELECT * FROM faktur;
SELECT * FROM kuitansi;

-- Mengganti Nama Tabel Pelanggan
RENAME TABLE pelanggan TO plg;
