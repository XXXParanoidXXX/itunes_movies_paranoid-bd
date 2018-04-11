/*
Banco de Dados dos filmes da biblioteca pessoal do iTunes de Vinicius dos Santos Lima, chamado 'itunes_movies_vinicius'
Script by Paranoid
*/

/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
/*Script de instalacao da estrutura do banco de dados*/
/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/

/*Criar o banco de dados de produçao*/
CREATE DATABASE itunes_movies_vinicius;

/*Conectar com o banco de dados*/
USE itunes_movies_vinicius;

/*Criar tabela sobre filmes relacionado as tabelas estudio, atores, diretor, produtor e roteirista, recebendo suas fk*/
CREATE TABLE filmes (
	id_filmes_pk INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    genero VARCHAR(50),
    ano YEAR,
    descricao VARCHAR(1000),
    duracao TIME(1),
    audio VARCHAR(50),
    legenda VARCHAR(50),
    definicao ENUM('SD', 'HD', '4K HDR'),
    faixa_etaria INT(2),
    itunes_extra ENUM('S', 'N'),
    estudio_id_estudio_fk INT NOT NULL UNIQUE
);

/*Criar tabela sobre atores*/
CREATE TABLE atores (
	id_atores_pk INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    sexo ENUM('M', 'F'),
    nascimento DATE,
    morte DATE,
    nacionalidade VARCHAR(50),
    atividade YEAR
);

/*Criar tabela sobre diretores*/
CREATE TABLE diretor (
	id_diretor_pk INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    sexo ENUM('M', 'F'),
    nascimento DATE,
    morte DATE,
    nacionalidade VARCHAR(50),
    atividade YEAR
);

/*Criar tabela sobre produtores*/
CREATE TABLE produtor (
	id_produtor_pk INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    sexo ENUM('M', 'F'),
    nascimento DATE,
    morte DATE,
    nacionalidade VARCHAR(50),
    atividade YEAR
);

/*Criar tabela sobre roteiristas*/
CREATE TABLE roteirista (
	id_roteirista_pk INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    sexo ENUM('M', 'F'),
    nascimento DATE,
    morte DATE,
    nacionalidade VARCHAR(50),
    atividade YEAR
);

/*Criar tabela sobre estudios*/
CREATE TABLE estudio (
	id_estudio_pk INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    fundacao YEAR,
    encerramento YEAR,
    faturamento FLOAT(12,3),
    website VARCHAR(100),
    estudio_localizacao_id_estudio_localizacao_fk INT NOT NULL UNIQUE
);

/*Criar tabela sobre enderecos dos estudios relacionado a tabela estudios, recebendo sua fk*/
CREATE TABLE estudio_localizacao (
	id_estudio_localizacao_pk INT PRIMARY KEY AUTO_INCREMENT,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(50),
    pais VARCHAR(50) NOT NULL
);

/*Criar tabela associativa entre as tabelas sobre filmes e atores*/
CREATE TABLE filmes_has_atores (
    filmes_id_filmes_pk INT,
	atores_id_atores_pk INT,
    PRIMARY KEY(filmes_id_filmes_pk, atores_id_atores_pk)
);

/*Criar tabela associativa entre as tabelas sobre filmes e diretor*/
CREATE TABLE filmes_has_diretor (
	filmes_id_filmes_pk INT,
	diretor_id_diretor_pk INT,
    PRIMARY KEY(filmes_id_filmes_pk, diretor_id_diretor_pk)
);

/*Criar tabela associativa entre as tabelas sobre filmes e produtor*/
CREATE TABLE filmes_has_produtor (
	filmes_id_filmes_pk INT,
	produtor_id_produtor_pk INT,
    PRIMARY KEY(filmes_id_filmes_pk, produtor_id_produtor_pk)
);

/*Criar tabela associativa entre as tabelas sobre filmes e roteirista*/
CREATE TABLE filmes_has_roteirista (
	filmes_id_filmes_pk INT,
	roteirista_id_roteirista_pk INT,
    PRIMARY KEY(filmes_id_filmes_pk, roteirista_id_roteirista_pk)
);

/*Criar constraints FK das tabelas ate aqui criadas*/
ALTER TABLE filmes ADD CONSTRAINT estudio_para_filme_fk FOREIGN KEY(estudio_id_estudio_fk) REFERENCES estudio(id_estudio_pk);
ALTER TABLE estudio ADD CONSTRAINT estudio_localizacao_para_estudio_fk FOREIGN KEY(estudio_localizacao_id_estudio_localizacao_fk) 
REFERENCES estudio_localizacao(id_estudio_localizacao_pk);

/*Criar constraints FK para as tabelas associativas ate aqui criadas*/
ALTER TABLE filmes_has_atores ADD CONSTRAINT filmes_x_atores FOREIGN KEY(filmes_id_filmes_pk) REFERENCES filmes(id_filmes_pk);
ALTER TABLE filmes_has_atores ADD CONSTRAINT atores_x_filmes FOREIGN KEY(atores_id_atores_pk) REFERENCES atores(id_atores_pk);

ALTER TABLE filmes_has_diretor ADD CONSTRAINT filmes_x_diretor FOREIGN KEY(filmes_id_filmes_pk) REFERENCES filmes(id_filmes_pk);
ALTER TABLE filmes_has_diretor ADD CONSTRAINT diretor_x_filmes FOREIGN KEY(diretor_id_diretor_pk) REFERENCES diretor(id_diretor_pk);

ALTER TABLE filmes_has_produtor ADD CONSTRAINT filmes_x_produtor FOREIGN KEY(filmes_id_filmes_pk) REFERENCES filmes(id_filmes_pk);
ALTER TABLE filmes_has_produtor ADD CONSTRAINT produtor_x_filmes FOREIGN KEY(produtor_id_produtor_pk) REFERENCES produtor(id_produtor_pk);

ALTER TABLE filmes_has_roteirista ADD CONSTRAINT filmes_x_roteirista FOREIGN KEY(filmes_id_filmes_pk) REFERENCES filmes(id_filmes_pk);
ALTER TABLE filmes_has_roteirista ADD CONSTRAINT roteirista_x_filmes FOREIGN KEY(roteirista_id_roteirista_pk) REFERENCES roteirista(id_roteirista_pk);

/* Criar backup logico com auditoria*/

/*Criar o banco de dados de backup e auditoria*/
CREATE DATABASE itunes_movies_vinicius_bkp;

/*Conectar com o banco de dados de backup e auditoria*/
USE itunes_movies_vinicius_bkp;

/*Criar tabela de backup e auditoria da tabela de producao sobre filmes*/
CREATE TABLE filmes_bkp (
	id_filmes_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    id_filmes_pk_bkp INT,
	nome_original_bkp VARCHAR(100),
    nome_alterado_bkp VARCHAR(100),
    genero_original_bkp VARCHAR(50),
    genero_alterado_bkp VARCHAR(50),
    ano_original_bkp YEAR,
    ano_alterado_bkp YEAR,
    descricao_original_bkp VARCHAR(1000),
    descricao_alterado_bkp VARCHAR(1000),
    duracao_original_bkp TIME(1),
    duracao_alterado_bkp TIME(1),
    audio_original_bkp VARCHAR(50),
    audio_alterado_bkp VARCHAR(50),
    legenda_original_bkp VARCHAR(50),
    legenda_alterado_bkp VARCHAR(50),
    definicao_original_bkp ENUM('SD', 'HD', '4K HDR'),
    definicao_alterado_bkp ENUM('SD', 'HD', '4K HDR'),
    faixa_etaria_original_bkp INT(2),
    faixa_etaria_alterado_bkp INT(2),
    itunes_extra_original_bkp ENUM('S', 'N'),
    itunes_extra_alterado_bkp ENUM('S', 'N'),
    estudio_id_estudio_fk_original_bkp INT,
    estudio_id_estudio_fk_alterado_bkp INT,
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Criar tabela de backup e auditoria da tabela de producao sobre atores*/
CREATE TABLE atores_bkp (
	id_atores_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    id_atores_pk_bkp INT,
    nome_original_bkp VARCHAR(100),
    nome_alterado_bkp VARCHAR(100),
    sexo_original_bkp ENUM('M', 'F'),
    sexo_alterado_bkp ENUM('M', 'F'),
    nascimento_original_bkp DATE,
    nascimento_alterado_bkp DATE,
    morte_original_bkp DATE,
    morte_alterado_bkp DATE,
    nacionalidade_original_bkp VARCHAR(50),
    nacionalidade_alterado_bkp VARCHAR(50),
    atividade_original_bkp YEAR,
    atividade_alterado_bkp YEAR,
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Criar tabela de backup e auditoria da tabela de producao sobre diretor*/
CREATE TABLE diretor_bkp (
	id_diretor_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    id_diretor_pk_bkp INT,
    nome_original_bkp VARCHAR(100),
    nome_alterado_bkp VARCHAR(100),
    sexo_original_bkp ENUM('M', 'F'),
    sexo_alterado_bkp ENUM('M', 'F'),
    nascimento_original_bkp DATE,
    nascimento_alterado_bkp DATE,
    morte_original_bkp DATE,
    morte_alterado_bkp DATE,
    nacionalidade_original_bkp VARCHAR(50),
    nacionalidade_alterado_bkp VARCHAR(50),
    atividade_original_bkp YEAR,
    atividade_alterado_bkp YEAR,
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Criar tabela de backup e auditoria da tabela de producao sobre produtor*/
CREATE TABLE produtor_bkp (
	id_produtor_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    id_produtor_pk_bkp INT,
    nome_original_bkp VARCHAR(100),
    nome_alterado_bkp VARCHAR(100),
    sexo_original_bkp ENUM('M', 'F'),
    sexo_alterado_bkp ENUM('M', 'F'),
    nascimento_original_bkp DATE,
    nascimento_alterado_bkp DATE,
    morte_original_bkp DATE,
    morte_alterado_bkp DATE,
    nacionalidade_original_bkp VARCHAR(50),
    nacionalidade_alterado_bkp VARCHAR(50),
    atividade_original_bkp YEAR,
    atividade_alterado_bkp YEAR,
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Criar tabela de backup e auditoria da tabela de producao sobre roteirista*/
CREATE TABLE roteirista_bkp (
	id_roteirista_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    id_roteirista_pk_bkp INT,
    nome_original_bkp VARCHAR(100),
    nome_alterado_bkp VARCHAR(100),
    sexo_original_bkp ENUM('M', 'F'),
    sexo_alterado_bkp ENUM('M', 'F'),
    nascimento_original_bkp DATE,
    nascimento_alterado_bkp DATE,
    morte_original_bkp DATE,
    morte_alterado_bkp DATE,
    nacionalidade_original_bkp VARCHAR(50),
    nacionalidade_alterado_bkp VARCHAR(50),
    atividade_original_bkp YEAR,
    atividade_alterado_bkp YEAR,
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Criar tabela de backup e auditoria da tabela de producao sobre estudio*/
CREATE TABLE estudio_bkp (
	id_estudio_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    id_estudio_pk_bkp INT,
    nome_original_bkp VARCHAR(100),
    nome_alterado_bkp VARCHAR(100),
    fundacao_original_bkp YEAR,
    fundacao_alterado_bkp YEAR,
    encerramento_original_bkp YEAR,
    encerramento_alterado_bkp YEAR,
    faturamento_original_bkp FLOAT(12,3),
    faturamento_alterado_bkp FLOAT(12,3),
    website_original_bkp VARCHAR(100),
    website_alterado_bkp VARCHAR(100),
    estudio_localizacao_id_estudio_localizacao_fk_original_bkp INT,
    estudio_localizacao_id_estudio_localizacao_fk_alterado_bkp INT,
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Criar tabela de backup e auditoria da tabela de producao sobre estudio_localizacao*/
CREATE TABLE estudio_localizacao_bkp (
	id_estudio_localizacao_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    id_estudio_localizacao_pk_bkp INT,
    cidade_original_bkp VARCHAR(50),
    cidade_alterado_bkp VARCHAR(50),
    estado_original_bkp VARCHAR(50),
    estado_alterado_bkp VARCHAR(50),
    pais_original_bkp VARCHAR(50),
    pais_alterado_bkp VARCHAR(50),
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Criar tabela de backup e auditoria da tabela associativa entre as tabelas sobre filmes e atores*/
CREATE TABLE filmes_has_atores_bkp (
	id_filmes_has_atores_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    filmes_id_filmes_pk_original_bkp INT,
    filmes_id_filmes_pk_alterado_bkp INT,
    atores_id_atores_pk_original_bkp INT,
    atores_id_atores_pk_alterado_bkp INT,
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Criar tabela de backup e auditoria da tabela associativa entre as tabelas sobre filmes e diretor*/
CREATE TABLE filmes_has_diretor_bkp (
	id_filmes_has_diretor_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    filmes_id_filmes_pk_original_bkp INT,
    filmes_id_filmes_pk_alterado_bkp INT,
    diretor_id_diretor_pk_original_bkp INT,
    diretor_id_diretor_pk_alterado_bkp INT,
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Criar tabela de backup e auditoria da tabela associativa entre as tabelas sobre filmes e produtor*/
CREATE TABLE filmes_has_produtor_bkp (
	id_filmes_has_produtor_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    filmes_id_filmes_pk_original_bkp INT,
    filmes_id_filmes_pk_alterado_bkp INT,
    produtor_id_produtor_pk_original_bkp INT,
    produtor_id_produtor_pk_alterado_bkp INT,
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Criar tabela de backup e auditoria da tabela associativa entre as tabelas sobre filmes e roteirista*/
CREATE TABLE filmes_has_roteirista_bkp (
	id_filmes_has_roteirista_bkp_pk INT PRIMARY KEY AUTO_INCREMENT,
    filmes_id_filmes_pk_original_bkp INT,
    filmes_id_filmes_pk_alterado_bkp INT,
    roteirista_id_roteirista_pk_original_bkp INT,
    roteirista_id_roteirista_pk_alterado_bkp INT,
    usuario VARCHAR(50),
    data DATETIME,
    evento ENUM('I', 'D', 'U')
);

/*Conectar com o banco de dados em producao*/
USE itunes_movies_vinicius;

/*Criar triggers de backup e auditoria, visando comunicacao com o banco de dados de backup logico*/

/*ALTERAR O DELIMITADOR PARA PROGRAMACAO*/
DELIMITER $

/*Criar triggers de backup e auditoria da tabela em producao sobre filmes*/
CREATE TRIGGER trg_backup_filmes_insert AFTER INSERT ON filmes 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_bkp 
    VALUES(NULL, NEW.id_filmes_pk, NULL, NEW.nome, NULL, NEW.genero, NULL, NEW.ano, NULL, NEW.descricao, NULL, NEW.duracao, NULL, NEW.audio, NULL, NEW.legenda,
    NULL, NEW.definicao, NULL, NEW.faixa_etaria, NULL, NEW.itunes_extra, NULL, NEW.estudio_id_estudio_fk, CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_filmes_update AFTER UPDATE ON filmes 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_bkp VALUES(NULL, OLD.id_filmes_pk, OLD.nome, NEW.nome, OLD.genero, NEW.genero, OLD.ano, NEW.ano, OLD.descricao, NEW.descricao, 
    OLD.duracao, NEW.duracao, OLD.audio, NEW.audio, OLD.legenda, NEW.legenda, OLD.definicao, NEW.definicao, OLD.faixa_etaria, NEW.faixa_etaria, OLD.itunes_extra, NEW.itunes_extra, 
    OLD.estudio_id_estudio_fk, NEW.estudio_id_estudio_fk, CURRENT_USER(), NOW(), 'U');
END$

CREATE TRIGGER trg_backup_filmes_delete BEFORE DELETE ON filmes 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_bkp VALUES(NULL, OLD.id_filmes_pk, OLD.nome,  NULL, OLD.genero, NULL, OLD.ano, NULL, OLD.descricao, NULL, OLD.duracao, NULL, 
    OLD.audio, NULL, OLD.legenda, NULL, OLD.definicao, NULL, OLD.faixa_etaria, NULL, OLD.itunes_extra, NULL, OLD.estudio_id_estudio_fk, NULL, CURRENT_USER(), NOW(), 'D');
END$

/*Criar triggers de backup e auditoria da tabela em producao sobre atores*/
CREATE TRIGGER trg_backup_atores_insert AFTER INSERT ON atores 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.atores_bkp VALUES(NULL, NEW.id_atores_pk, NULL, NEW.nome, NULL, NEW.sexo, NULL, NEW.nascimento, NULL, NEW.morte, NULL, NEW.nacionalidade, 
    NULL, NEW.atividade, CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_atores_update AFTER UPDATE ON atores 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.atores_bkp VALUES(NULL, OLD.id_atores_pk, OLD.nome, NEW.nome, OLD.sexo, NEW.sexo, OLD.nascimento, NEW.nascimento, OLD.morte, NEW.morte, 
    OLD.nacionalidade, NEW.nacionalidade, OLD.atividade, NEW.atividade, CURRENT_USER(), NOW(), 'U');
END$

CREATE TRIGGER trg_backup_atores_delete BEFORE DELETE ON atores 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.atores_bkp VALUES(NULL, OLD.id_atores_pk, OLD.nome, NULL, OLD.sexo, NULL, OLD.nascimento, NULL, OLD.morte, NULL, 
    OLD.nacionalidade, NULL, OLD.atividade, NULL, CURRENT_USER(), NOW(), 'D');
END$

/*Criar triggers de backup e auditoria da tabela em producao sobre diretor*/
CREATE TRIGGER trg_backup_diretor_insert AFTER INSERT ON diretor 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.diretor_bkp VALUES(NULL, NEW.id_diretor_pk, NULL, NEW.nome, NULL, NEW.sexo, NULL, NEW.nascimento, NULL, NEW.morte, NULL, NEW.nacionalidade, 
    NULL, NEW.atividade, CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_diretor_update AFTER UPDATE ON diretor 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.diretor_bkp VALUES(NULL, OLD.id_diretor_pk, OLD.nome, NEW.nome, OLD.sexo, NEW.sexo, OLD.nascimento, NEW.nascimento, OLD.morte, NEW.morte,
    OLD.nacionalidade, NEW.nacionalidade, OLD.atividade, NEW.atividade, CURRENT_USER(), NOW(), 'U');
END$

CREATE TRIGGER trg_backup_diretor_delete BEFORE DELETE ON diretor 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.diretor_bkp VALUES(NULL, OLD.id_diretor_pk, OLD.nome, NULL, OLD.sexo, NULL, OLD.nascimento, NULL, OLD.morte, NULL,
    OLD.nacionalidade, NULL, OLD.atividade, NULL, CURRENT_USER(), NOW(), 'D');
END$

/*Criar triggers de backup e auditoria da tabela em producao sobre produtor*/
CREATE TRIGGER trg_backup_produtor_insert AFTER INSERT ON produtor 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.produtor_bkp VALUES(NULL, NEW.id_produtor_pk, NULL, NEW.nome, NULL, NEW.sexo, NULL, NEW.nascimento, NULL, NEW.morte, NULL, NEW.nacionalidade, 
    NULL, NEW.atividade, CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_produtor_update AFTER UPDATE ON produtor 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.produtor_bkp VALUES(NULL, OLD.id_produtor_pk, OLD.nome, NEW.nome, OLD.sexo, NEW.sexo, OLD.nascimento, NEW.nascimento, OLD.morte, NEW.morte,
    OLD.nacionalidade, NEW.nacionalidade, OLD.atividade, NEW.atividade, CURRENT_USER(), NOW(), 'U');
END$

CREATE TRIGGER trg_backup_produtor_delete BEFORE DELETE ON produtor 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.produtor_bkp VALUES(NULL, OLD.id_produtor_pk, OLD.nome, NULL, OLD.sexo, NULL, OLD.nascimento, NULL, OLD.morte, NULL,
    OLD.nacionalidade, NULL, OLD.atividade, NULL, CURRENT_USER(), NOW(), 'D');
END$

/*Criar triggers de backup e auditoria da tabela em producao sobre roteirista*/
CREATE TRIGGER trg_backup_roteirista_insert AFTER INSERT ON roteirista 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.roteirista_bkp VALUES(NULL, NEW.id_roteirista_pk, NULL, NEW.nome, NULL, NEW.sexo, NULL, NEW.nascimento, NULL, NEW.morte, NULL, NEW.nacionalidade, 
    NULL, NEW.atividade, CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_roteirista_update AFTER UPDATE ON roteirista 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.roteirista_bkp VALUES(NULL, OLD.id_roteirista_pk, OLD.nome, NEW.nome, OLD.sexo, NEW.sexo, OLD.nascimento, NEW.nascimento, OLD.morte, NEW.morte,
    OLD.nacionalidade, NEW.nacionalidade, OLD.atividade, NEW.atividade, CURRENT_USER(), NOW(), 'U');
END$

CREATE TRIGGER trg_backup_roteirista_delete BEFORE DELETE ON roteirista 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.roteirista_bkp VALUES(NULL, OLD.id_roteirista_pk, OLD.nome, NULL, OLD.sexo, NULL, OLD.nascimento, NULL, OLD.morte, NULL,
    OLD.nacionalidade, NULL, OLD.atividade, NULL, CURRENT_USER(), NOW(), 'D');
END$

/*Criar triggers de backup e auditoria da tabela em producao sobre estudio*/
CREATE TRIGGER trg_backup_estudio_insert AFTER INSERT ON estudio 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.estudio_bkp VALUES(NULL, NEW.id_estudio_pk, NULL, NEW.nome, NULL, NEW.fundacao, NULL, NEW.encerramento, NULL, NEW.faturamento, 
    NULL, NEW.website, NULL, NEW.estudio_localizacao_id_estudio_localizacao_fk, CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_estudio_update AFTER UPDATE ON estudio 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.estudio_bkp VALUES(NULL, OLD.id_estudio_pk, OLD.nome, NEW.nome, OLD.fundacao, NEW.fundacao, OLD.encerramento, NEW.encerramento, 
    OLD.faturamento, NEW.faturamento, OLD.website, NEW.website, OLD.estudio_localizacao_id_estudio_localizacao_fk, NEW.estudio_localizacao_id_estudio_localizacao_fk, CURRENT_USER(), NOW(), 
    'U');
END$

CREATE TRIGGER trg_backup_estudio_delete BEFORE DELETE ON estudio 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.estudio_bkp VALUES(NULL, OLD.id_estudio_pk, OLD.nome, NULL, OLD.fundacao, NULL, OLD.encerramento, NULL, OLD.faturamento, NULL, 
    OLD.website, NULL, OLD.estudio_localizacao_id_estudio_localizacao_fk, NULL, CURRENT_USER(), NOW(), 'D');
END$

/*Criar triggers de backup e auditoria da tabela em producao sobre estudio_localizacao*/
CREATE TRIGGER trg_backup_estudio_localizacao_insert AFTER INSERT ON estudio_localizacao 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.estudio_localizacao_bkp VALUES(NULL, NEW.id_estudio_localizacao_pk, NULL, NEW.cidade, NULL, NEW.estado, NULL, NEW.pais, 
    CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_estudio_localizacao_update AFTER UPDATE ON estudio_localizacao 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.estudio_localizacao_bkp VALUES(NULL, OLD.id_estudio_localizacao_pk, OLD.cidade, NEW.cidade, OLD.estado, NEW.estado, OLD.pais, NEW.pais, 
    CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_estudio_localizacao_delete BEFORE DELETE ON estudio_localizacao 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.estudio_localizacao_bkp VALUES(NULL, OLD.id_estudio_localizacao_pk, OLD.cidade, NULL, OLD.estado, NULL, OLD.pais, NULL, 
    CURRENT_USER(), NOW(), 'D');
END$

/*Criar triggers de backup e auditoria da tabela associativa em producao sobre filmes_has_atores*/
CREATE TRIGGER trg_backup_filmes_has_atores_insert AFTER INSERT ON filmes_has_atores 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_atores_bkp VALUES(NULL, NULL, NEW.filmes_id_filmes_pk, NULL, NEW.atores_id_atores_pk, 
    CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_filmes_has_atores_update AFTER UPDATE ON filmes_has_atores 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_atores_bkp VALUES(NULL, OLD.filmes_id_filmes_pk, NEW.filmes_id_filmes_pk, 
    OLD.atores_id_atores_pk, NEW.atores_id_atores_pk, CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_filmes_has_atores_delete BEFORE DELETE ON filmes_has_atores
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_atores_bkp VALUES(NULL, OLD.filmes_id_filmes_pk, NULL, OLD.atores_id_atores_pk, NULL,
    CURRENT_USER(), NOW(), 'D');
END$


/*Criar triggers de backup e auditoria da tabela associativa em producao sobre filmes_has_diretor*/
CREATE TRIGGER trg_backup_filmes_has_diretor_insert AFTER INSERT ON filmes_has_diretor 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_diretor_bkp VALUES(NULL, NULL, NEW.filmes_id_filmes_pk, NULL, NEW.diretor_id_diretor_pk, 
    CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_filmes_has_diretor_update AFTER UPDATE ON filmes_has_diretor 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_diretor_bkp VALUES(NULL, OLD.filmes_id_filmes_pk, NEW.filmes_id_filmes_pk, 
    OLD.diretor_id_diretor_pk, NEW.diretor_id_diretor_pk, CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_filmes_has_diretor_delete BEFORE DELETE ON filmes_has_diretor
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_diretor_bkp VALUES(NULL, OLD.filmes_id_filmes_pk, NULL, OLD.diretor_id_diretor_pk, NULL,
    CURRENT_USER(), NOW(), 'D');
END$

/*Criar triggers de backup e auditoria da tabela associativa em producao sobre filmes_has_produtor*/
CREATE TRIGGER trg_backup_filmes_has_produtor_insert AFTER INSERT ON filmes_has_produtor
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_produtor_bkp VALUES(NULL, NULL, NEW.filmes_id_filmes_pk, NULL, NEW.produtor_id_produtor_pk, 
    CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_filmes_has_produtor_update AFTER UPDATE ON filmes_has_produtor 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_produtor_bkp VALUES(NULL, OLD.filmes_id_filmes_pk, NEW.filmes_id_filmes_pk, 
    OLD.produtor_id_produtor_pk, NEW.produtor_id_produtor_pk, CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_filmes_has_produtor_delete BEFORE DELETE ON filmes_has_produtor
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_produtor_bkp VALUES(NULL, OLD.filmes_id_filmes_pk, NULL, OLD.produtor_id_produtor_pk, NULL,
    CURRENT_USER(), NOW(), 'D');
END$

/*Criar triggers de backup e auditoria da tabela associativa em producao sobre filmes_has_roteirista*/
CREATE TRIGGER trg_backup_filmes_has_roteirista_insert AFTER INSERT ON filmes_has_roteirista
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_roteirista_bkp VALUES(NULL, NULL, NEW.filmes_id_filmes_pk, NULL, NEW.roteirista_id_roteirista_pk, 
    CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_filmes_has_roteirista_update AFTER UPDATE ON filmes_has_roteirista 
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_roteirista_bkp VALUES(NULL, OLD.filmes_id_filmes_pk, NEW.filmes_id_filmes_pk, 
    OLD.roteirista_id_roteirista_pk, NEW.roteirista_id_roteirista_pk, CURRENT_USER(), NOW(), 'I');
END$

CREATE TRIGGER trg_backup_filmes_has_roteirista_delete BEFORE DELETE ON filmes_has_roteirista
FOR EACH ROW
BEGIN
	INSERT INTO itunes_movies_vinicius_bkp.filmes_has_roteirista_bkp VALUES(NULL, OLD.filmes_id_filmes_pk, NULL, OLD.roteirista_id_roteirista_pk, NULL,
    CURRENT_USER(), NOW(), 'D');
END$

/*ALTERAR O DELIMITADOR PARA SCRIPT*/
DELIMITER ;

USE itunes_movies_vinicius;

/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
/*Script de populacao do banco de dados*/
/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/

/*Ordem de insercao para possibilitar o relacionamento:
1) estudio_localizacao
2) estudio
3) filme
4) tabelas do tema elenco e equipe
5) tabelas associativas
*/

/*1) estudio_localizacao*/
INSERT INTO estudio_localizacao(cidade, estado, pais) 
VALUES(
'Los Angeles',
'California',
'Estados Unidos'); 
/*estudio_localizacao_pk = 1*/

INSERT INTO estudio_localizacao(cidade, estado, pais) 
VALUES(
'Burbank',
'California',
'Estados Unidos'); 
/*estudio_localizacao_pk = 2*/

/*2) estudio*/
INSERT INTO estudio(nome, fundacao, encerramento, faturamento, website, estudio_localizacao_id_estudio_localizacao_fk) 
VALUES(
'Twentieth Century Fox Film Corporation',
1935,
NULL,
27320000000,
'https://www.foxmovies.com',
1);
/*id_estudio_pk = 1*/

INSERT INTO estudio(nome, fundacao, encerramento, faturamento, website, estudio_localizacao_id_estudio_localizacao_fk) 
VALUES(
'Warner Bros. Entertainment',
1923,
NULL,
12999000000,
'https://www.warnerbros.com',
2);
/*id_estudio_pk = 2*/

/*3) filme*/ 
/*Avatar*/
INSERT INTO filmes (nome, genero, ano, descricao, duracao, audio, legenda, definicao, faixa_etaria, itunes_extra, estudio_id_estudio_fk)
VALUES(
'Avatar',
'Ficção científica e fantasia',
2009,
'Experimente o mundo de tirar o fôlego de Avatar como nunca antes com esta Edição Estendida de Colecionador! 
Siga a viagem dos realizadores do documentário Capturando Avatar, com entrevistas com James Cameron, Jon Landau, elenco e equipe. 
Explore três versões do filme, incluindo mais de 45 minutos de cenas nunca antes visto, a Exclusive Alternate Opening on Earth, The Art of Avatar e muito mais!',
'02:50:00',
'Ingles',
'Portugues',
'HD',
12,
'S',
1);
/*id_filmes_pk = 1*/

/*Interstellar*/
INSERT INTO filmes (nome, genero, ano, descricao, duracao, audio, legenda, definicao, faixa_etaria, itunes_extra, estudio_id_estudio_fk)
VALUES(
'Interstellar',
'Ficção científica e fantasia',
2014,
'Com nosso tempo na Terra chegando ao fim, uma equipe de exploradores realiza a missão mais importante da história humana: 
viajar para além desta galáxia para descobrir se a humanidade tem algum futuro entre as estrelas.',
'02:49:00',
'Ingles',
'Portugues',
'HD',
10,
'S',
2);
/*id_filmes_pk = 2*/

/*Matrix*/
INSERT INTO filmes (nome, genero, ano, descricao, duracao, audio, legenda, definicao, faixa_etaria, itunes_extra, estudio_id_estudio_fk)
VALUES(
'Matrix',
'Ficção científica e fantasia',
1999,
'O que vemos: Nosso dia a dia é verdadeiro. - O que é real: O mundo é uma farsa, construído por uma das mais poderosas máquinas com inteligência artificial para nos controlar. - 
Proezas de tirar o fôlego. Efeitos alucinantes. Cenas de arrebentar. Keanu Reeves e Laurence Fishburne lutam pela libertação da humanidade em Matrix, um suspense cibernético para se ver e rever 
muitas vezes, escrito e dirigido pelos irmãos Wachowski (Ligadas pelo Desejo). Uma surpreendente história, com efeitos visuais alucinantes, marcando uma nova era no cinema. Um filme arrasador.',
'02:17:00',
'Ingles',
'Portugues',
'HD',
10,
'N',
2);
/*id_filmes_pk = 3*/

/*Matrix Reloded*/
INSERT INTO filmes (nome, genero, ano, descricao, duracao, audio, legenda, definicao, faixa_etaria, itunes_extra, estudio_id_estudio_fk)
VALUES(
'Matrix Reloded',
'Ficção científica e fantasia',
2003,
'Nuvens de Sentinelas. Clones do agente Smith. Neo pode voar, mas talvez nem mesmo o "Escolhido", com novos e impressionantes poderes, seja capaz de conter o avanço das máquinas. 
Neo, Morpheus e Trinity. Todos estão de volta para o poderosos segundo capítulo da trilogia Matrix - juntamente com novos aliados - , batalhando contra inimigos que são clonados, evoluíram e 
estão cada vez mais próximos de destruir o último enclave humano no planeta. Também voltam os Irmãos Wachowski e o produtor Joel Silver, expandindo sua visão a novos limites, com um espetáculo 
que choca os sentidos, acelera o coração e desenha os caminhos futuros do cinema.. O Que é a Matrix? A questão ainda não é respondida totalmente, e acaba conduzinndo a uma outra: 
Quem criou a Matrix? Matrix Reloaded é um filme pleno de revelações, que abre caminho para inúmeras "revoluções".',
'02:19:00',
'Ingles',
'Portugues',
'HD',
12,
'S',
2);
/*id_filmes_pk = 4*/

/*4) tabelas do tema elenco e equipe*/

/*Inserir dados na tabela sobre atores*/
INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Sam Worthington',
'M',
19760802,
NULL,
'Australia',
2000); 
/*id_atores_pk = 1 */
/*Avatar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Zoe Saldana',
'F',
19780619,
NULL,
'Estados Unidos',
2000); 
/*id_atores_pk = 2 */
/*Avatar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Stephen Lang',
'M',
19520711,
NULL,
'Estados Unidos',
1985); 
/*id_atores_pk = 3 */
/*Avatar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Michelle Rodriguez',
'F',
19780712,
NULL,
'Estados Unidos',
1997); 
/*id_atores_pk = 4 */
/*Avatar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES(
'Sigourney Weaver',
'F',
19491008,
NULL,
'Estados Unidos',
1976); 
/*id_atores_pk = 5 */
/*Avatar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Sonia Yee',
'F',
NULL,
NULL,
NULL,
NULL); 
/*id_atores_pk = 6 */
/*Avatar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES(
'Matthew McConaughey',
'M',
19691104,
NULL,
'Estados Unidos',
1993
); 
/*id_atores_pk = 7*/
/*Interstellar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Anne Hathaway',
'F',
19821112,
NULL,
'Estados Unidos',
1999
); 
/*id_atores_pk = 8*/
/*Interstellar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Jessica Chastain',
'F',
19770324,
NULL,
'Estados Unidos',
2004
); 
/*id_atores_pk = 9*/
/*Interstellar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Bill Irwin',
'M',
19500411,
NULL,
'Estados Unidos',
1974
); 
/*id_atores_pk = 10*/
/*Interstellar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Ellen Burstyn',
'F',
19351207,
NULL,
'Estados Unidos',
1961
); 
/*id_atores_pk = 11*/
/*Interstellar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Michael Caine',
'M',
19330314,
NULL,
'Inglaterra',
1956
); 
/*id_atores_pk = 12*/
/*Interstellar*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Keanu Reeves',
'M',
19640902,
NULL,
'Libano',
1984
); 
/*id_atores_pk = 13*/
/*Matrix*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Laurence Fishburne',
'M',
19610730,
NULL,
'Estados Unidos',
1972
); 
/*id_atores_pk = 14*/
/*Matrix*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Carrie-Anne Moss',
'F',
19670821,
NULL,
'Canada',
1988
); 
/*id_atores_pk = 15*/
/*Matrix*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Hugo Weaving',
'M',
19600404,
NULL,
'Ibadan',
1981
); 
/*id_atores_pk = 16*/
/*Matrix*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Joe Pantoliano',
'M',
19510912,
NULL,
'Estados Unidos',
1974
); 
/*id_atores_pk = 17*/
/*Matrix*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES(
'Gloria Foster',
'F',
19331115,
20010929,
'Estados Unidos',
1964
); 
/*id_atores_pk = 18*/
/*Matrix*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Marcus Chong',
'M',
19670708,
NULL,
'Estados Unidos',
1979
); 
/*id_atores_pk = 19*/
/*Matrix*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Julian Arahanga',
'M',
19721218,
NULL,
'Nova Zelandia',
1983
); 
/*id_atores_pk = 20 */
/*Matrix*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Belinda McClory',
'F',
19681101,
NULL,
'Australia',
1990
); 
/*id_atores_pk = 21*/
/*Matrix*/

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(); 
/*id_atores_pk = */

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(); 
/*id_atores_pk = */

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(); 
/*id_atores_pk = */

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(); 
/*id_atores_pk = */

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(); 
/*id_atores_pk = */

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(); 
/*id_atores_pk = */

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(); 
/*id_atores_pk = */

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(); 
/*id_atores_pk = */

INSERT INTO atores(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(); 
/*id_atores_pk = */


/*Inserir dados na tabela sobre diretores*/
INSERT INTO diretor(nome, sexo, nascimento, morte, nacionalidade, atividade)  
VALUES(
'James Cameron',
'M',
19540816,
NULL,
'Canada',
1976
);
/*id_diretor_pk = 1 */
/*Avatar*/

INSERT INTO diretor(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Christopher Nolan',
'M',
19700730,
NULL,
'Inglaterra',
1989
);
/*id_diretor_pk = 2*/
/*Interstellar*/

INSERT INTO diretor(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Andy Wachowski',
'M',
19671229,
NULL,
'Estados Unidos',
1994
);
/*id_diretor_pk = 3*/
/*Matrix*/

INSERT INTO diretor(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES(
'Larry Wachowski',
'M',
19650621,
NULL,
'Estados Unidos',
1994
);
/*id_diretor_pk = 4*/
/*Matrix*/

INSERT INTO diretor(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES();
/*id_diretor_pk = */

INSERT INTO diretor(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES();
/*id_diretor_pk = */

INSERT INTO diretor(nome, sexo, nascimento, morte, nacionalidade, atividade) 
VALUES();
/*id_diretor_pk = */


/*Inserir dados na tabela sobre produtores*/
INSERT INTO produtor(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES(
'Christopher Nolan',
'M',
19700730,
NULL,
'Inglaterra',
1989
);
/*id_produtor_pk = 1*/
/*Interstellar*/

INSERT INTO produtor(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES(
'Emma Thomas',
'F',
NULL,
NULL,
NULL,
1997
);
/*id_produtor_pk = 2*/
/*Interstellar*/

INSERT INTO produtor(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES(
'Lynda Obst',
'F',
19500414,
NULL,
'Estados Unidos',
1983
);
/*id_produtor_pk = 3*/
/*Interstellar*/

INSERT INTO produtor(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES(
'Joel Silver',
'M',
19520714,
NULL,
'Estados Unidos',
1976
);
/*id_produtor_pk = 4*/
/*Matrix*/

INSERT INTO produtor(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES();
/*id_produtor_pk = */

INSERT INTO produtor(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES();
/*id_produtor_pk = */

/*Inserir dados na tabela sobre roteiristas*/
INSERT INTO roteirista(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES(
'Christopher Nolan',
'M',
19700730,
NULL,
'Inglaterra',
1989
);
/*id_roteirista_pk = 1*/
/*Interstellar*/

INSERT INTO roteirista(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES(
'Jonathan Nolan',
'M',
19760606,
NULL,
'Inglaterra',
2000
);
/*id_roteirista_pk = 2*/
/*Interstellar*/

INSERT INTO roteirista(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES();
/*id_roteirista_pk = */

INSERT INTO roteirista(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES();
/*id_roteirista_pk = */

INSERT INTO roteirista(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES();
/*id_roteirista_pk = */

INSERT INTO roteirista(nome, sexo, nascimento, morte, nacionalidade, atividade)
VALUES();
/*id_roteirista_pk = */

/*Inserir relacionamentos nas tabelas associativas entre as tabelas sobre filmes e atores*/
/*Avatar x atores*/
INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(1,1);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(1,2);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(1,3);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(1,4);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(1,5);

/*Interstellar x atores*/
INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(2,7);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(2,8);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(2,9);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(2,10);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(2,11);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(2,12);

/*Matrix x atores*/
INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(3,13);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(3,14);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(3,15);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(3,16);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(3,17);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(3,18);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(3,19);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(3,20);

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES(3,21);

/*Matrix Reloded x atores*/
INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES();

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES();

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES();

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES();

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES();

INSERT INTO filmes_has_atores(filmes_id_filmes_pk , atores_id_atores_pk)
VALUES();

/*Inserir relacionamentos nas tabelas associativas entre as tabelas sobre filmes e diretor*/

/*Avatar x diretor*/
INSERT INTO filmes_has_diretor(filmes_id_filmes_pk, diretor_id_diretor_pk)
VALUES(1,1);

/*Interstellar x diretor*/
INSERT INTO filmes_has_diretor(filmes_id_filmes_pk, diretor_id_diretor_pk)
VALUES(2,2);

/*Matrix x diretor*/
INSERT INTO filmes_has_diretor(filmes_id_filmes_pk, diretor_id_diretor_pk)
VALUES(3,3);

INSERT INTO filmes_has_diretor(filmes_id_filmes_pk, diretor_id_diretor_pk)
VALUES(3,4);

/*Matrix Reloded*/
INSERT INTO filmes_has_diretor(filmes_id_filmes_pk, diretor_id_diretor_pk)
VALUES();

INSERT INTO filmes_has_diretor(filmes_id_filmes_pk, diretor_id_diretor_pk)
VALUES();

INSERT INTO filmes_has_diretor(filmes_id_filmes_pk, diretor_id_diretor_pk)
VALUES();

INSERT INTO filmes_has_diretor(filmes_id_filmes_pk, diretor_id_diretor_pk)
VALUES();

INSERT INTO filmes_has_diretor(filmes_id_filmes_pk, diretor_id_diretor_pk)
VALUES();

/*Inserir relacionamentos nas tabelas associativas entre as tabelas sobre filmes e produtor*/

/*Interstellar x produtor*/
INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES(2,1);

INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES(2,2);

INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES(2,3);

/*Matrix x produtor*/
INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES(3,4);

/*Matrix Reloded x produtor*/
INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES();

INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES();

INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES();

INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES();

INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES();
/*Inserir relacionamentos nas tabelas associativas entre as tabelas sobre filmes e roteirista*/
/*Interstellar x Roteirista*/
INSERT INTO filmes_has_roteirista(filmes_id_filmes_pk, roteirista_id_roteirista_pk)
VALUES(2,1);

INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES(2,2);

INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES();

INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES();

INSERT INTO filmes_has_produtor(filmes_id_filmes_pk, produtor_id_produtor_pk)
VALUES();

/*Melhorar codigo:
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

1) OK!!! FLOAT com separacao decimal na coluna faturamento da tabela estudio (acertar a tabela de backup e auditoria) - OK!!!;

2) Verificar error code 1062 nas tabelas associativas. 3 forma normal nao praticada quanto a tabela associativa com pk propria;

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/


/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
/*Script de criacao de views*/
/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/



/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
/*Script de consultas ao banco de dados*/
/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/

/*Criar procedures para as principais consultas, nomeando-as com nomes intuitivos para rapida identificacao da query programada*/

SELECT * FROM filmes;
SELECT * FROM estudio;
SELECT * FROM estudio_localizacao;
SELECT * FROM atores;
SELECT * FROM diretor;

SELECT * FROM filmes_has_atores;
SELECT * FROM filmes_has_diretor;
SELECT * FROM filmes_has_produtor;
SELECT * FROM filmes_has_roteirista;