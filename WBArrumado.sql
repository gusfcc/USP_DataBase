CREATE TABLE IF NOT EXISTS Funcionário (
  id_Func INTEGER NOT NULL,
  setor VARCHAR(3) NULL,
  prim_nome VARCHAR(50) NOT NULL,
  sobrenome VARCHAR(100) NOT NULL,
  sexo VARCHAR(4) NOT NULL,
  data_nasc DATE NOT NULL,
  est_civil VARCHAR(45) NULL,
  RG INTEGER NOT NULL,
  CPF INTEGER NOT NULL,
  nacionalidade VARCHAR(60) NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_Func));


CREATE UNIQUE INDEX id_Func_UNIQUE ON Funcionário (id_Func ASC);

CREATE UNIQUE INDEX CPF_UNIQUE ON Funcionário (CPF ASC);

CREATE UNIQUE INDEX RG_UNIQUE ON Funcionário (RG ASC);


-- -----------------------------------------------------
-- Table Experiência_Línguas
-- -----------------------------------------------------
DROP TABLE IF EXISTS Experiência_Línguas ;

CREATE TABLE IF NOT EXISTS Experiência_Línguas (
  Funcionário_id_Func INTEGER NOT NULL,
  lingua VARCHAR(45) NOT NULL,
  PRIMARY KEY (Funcionário_id_Func, lingua),
    FOREIGN KEY (Funcionário_id_Func)
    REFERENCES Funcionário (id_Func)
);

CREATE INDEX fk_Experiência_Línguas_Funcionário_idx ON Experiência_Línguas (Funcionário_id_Func ASC);


-- -----------------------------------------------------
-- Table Tripulação
-- -----------------------------------------------------
DROP TABLE IF EXISTS Tripulação ;

CREATE TABLE IF NOT EXISTS Tripulação (
  Funcionário_id_Func INTEGER NOT NULL,
  passaporte INTEGER NOT NULL,
  PRIMARY KEY (Funcionário_id_Func),
    FOREIGN KEY (Funcionário_id_Func)
    REFERENCES Funcionário (id_Func)
);

CREATE UNIQUE INDEX passaporte_UNIQUE ON Tripulação (passaporte ASC);


-- -----------------------------------------------------
-- Table Especialidade_Voo
-- -----------------------------------------------------
DROP TABLE IF EXISTS Especialidade_Voo ;

CREATE TABLE IF NOT EXISTS Especialidade_Voo (
  Tripulação_Funcionário_id_Func INTEGER NOT NULL,
  tipo_aeron VARCHAR(45) NOT NULL,
  PRIMARY KEY (Tripulação_Funcionário_id_Func, tipo_aeron),
    FOREIGN KEY (Tripulação_Funcionário_id_Func)
    REFERENCES Tripulação (Funcionário_id_Func)
);

CREATE INDEX fk_Especialidade_Voo_Tripulação1_idx ON Especialidade_Voo (Tripulação_Funcionário_id_Func ASC);


-- -----------------------------------------------------
-- Table Cep_Localidades
-- -----------------------------------------------------
DROP TABLE IF EXISTS Cep_Localidades ;

CREATE TABLE IF NOT EXISTS Cep_Localidades (
  cep INTEGER NOT NULL,
  país VARCHAR(65) NOT NULL,
  estado VARCHAR(100) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  PRIMARY KEY (cep))
;

CREATE UNIQUE INDEX cep_UNIQUE ON Cep_Localidades (cep ASC);


-- -----------------------------------------------------
-- Table Aeroporto
-- -----------------------------------------------------
DROP TABLE IF EXISTS Aeroporto ;

CREATE TABLE IF NOT EXISTS Aeroporto (
  cod_IATA INTEGER NOT NULL,
  nro_hangares INTEGER NULL,
  nro_terminais INTEGER NULL,
  nro_pistas INTEGER NULL,
  nome VARCHAR(80) NOT NULL,
  número INTEGER NULL,
  logradouro VARCHAR(45) NOT NULL,
  Cep_Localidades_cep INTEGER NOT NULL,
  PRIMARY KEY (cod_IATA),
    FOREIGN KEY (Cep_Localidades_cep)
    REFERENCES Cep_Localidades (cep));


CREATE UNIQUE INDEX cod_IATA_UNIQUE ON Aeroporto (cod_IATA ASC) ;

CREATE UNIQUE INDEX nome_UNIQUE ON Aeroporto (nome ASC) ;

CREATE UNIQUE INDEX logradouro_UNIQUE ON Aeroporto (logradouro ASC) ;

CREATE INDEX fk_Aeroporto_Cep_Localidades1_idx ON Aeroporto (Cep_Localidades_cep ASC) ;

CREATE UNIQUE INDEX Cep_Localidades_cep_UNIQUE ON Aeroporto (Cep_Localidades_cep ASC) ;


-- -----------------------------------------------------
-- Table Presencial
-- -----------------------------------------------------
DROP TABLE IF EXISTS Presencial ;

CREATE TABLE IF NOT EXISTS Presencial (
  Funcionário_id_Func INTEGER NOT NULL,
  cod_pres INTEGER NOT NULL,
  hro_trab INTEGER NULL,
  guichê VARCHAR(7) NOT NULL,
  Aeroporto_cod_IATA INTEGER NOT NULL,
  PRIMARY KEY (Funcionário_id_Func),
    FOREIGN KEY (Funcionário_id_Func)
    REFERENCES Funcionário (id_Func),
    FOREIGN KEY (Aeroporto_cod_IATA)
    REFERENCES Aeroporto (cod_IATA));


CREATE UNIQUE INDEX cod_pres_UNIQUE ON Presencial (cod_pres ASC) ;

CREATE INDEX fk_Presencial_Aeroporto1_idx ON Presencial (Aeroporto_cod_IATA ASC) ;


-- -----------------------------------------------------
-- Table Aeronave
-- -----------------------------------------------------
DROP TABLE IF EXISTS Aeronave ;

CREATE TABLE IF NOT EXISTS Aeronave (
  cod_aeronave INTEGER NOT NULL,
  qtde_assentos INTEGER NOT NULL,
  qtde_saidas_emerg INTEGER NOT NULL,
  qtde_trip_max INTEGER NOT NULL,
  milhas_max INTEGER NOT NULL,
  peso_max INTEGER NOT NULL,
  veloc_max INTEGER NOT NULL,
  milhas_totais INTEGER NULL,
  modelo VARCHAR(50) NOT NULL,
  Aeroporto_cod_IATA INTEGER NOT NULL,
  horario TIME NULL,
  data DATE NULL,
  PRIMARY KEY (cod_aeronave),
    FOREIGN KEY (Aeroporto_cod_IATA)
    REFERENCES Aeroporto (cod_IATA)
);

CREATE UNIQUE INDEX cod_aeronave_UNIQUE ON Aeronave (cod_aeronave ASC) ;

CREATE INDEX fk_Aeronave_Aeroporto1_idx ON Aeronave (Aeroporto_cod_IATA ASC) ;


-- -----------------------------------------------------
-- Table Voo
-- -----------------------------------------------------
DROP TABLE IF EXISTS Voo ;

CREATE TABLE IF NOT EXISTS Voo (
  cod_voo INTEGER NOT NULL,
  preco_passag INTEGER NULL,
  peso_aeron INTEGER NOT NULL,
  duracao_voo TIME NOT NULL,
  Aeroporto_cod_Chegada INTEGER NOT NULL,
  Aeroporto_cod_Saída INTEGER NOT NULL,
  horario_i TIME NOT NULL,
  data_i DATE NOT NULL,
  pista_i VARCHAR(45) NOT NULL,
  horario_f TIME NOT NULL,
  data_f DATE NOT NULL,
  pista_f VARCHAR(45) NOT NULL,
  Aeronave_cod_aeronave INTEGER NOT NULL,
  PRIMARY KEY (cod_voo),
    FOREIGN KEY (Aeroporto_cod_Chegada)
    REFERENCES Aeroporto (cod_IATA),
    FOREIGN KEY (Aeronave_cod_aeronave)
    REFERENCES Aeronave (cod_aeronave),
    FOREIGN KEY (Aeroporto_cod_Saída)
    REFERENCES Aeroporto (cod_IATA)
);

CREATE UNIQUE INDEX cod_voo_UNIQUE ON Voo (cod_voo ASC) ;

CREATE INDEX fk_Voo_Aeroporto1_idx ON Voo (Aeroporto_cod_Chegada ASC) ;

CREATE INDEX fk_Voo_Aeronave1_idx ON Voo (Aeronave_cod_aeronave ASC) ;

CREATE INDEX fk_Voo_Aeroporto2_idx ON Voo (Aeroporto_cod_Saída ASC) ;


-- -----------------------------------------------------
-- Table Tripulação_Voo
-- -----------------------------------------------------
DROP TABLE IF EXISTS Tripulação_Voo ;

CREATE TABLE IF NOT EXISTS Tripulação_Voo (
  Voo_cod_voo INTEGER NOT NULL,
  Tripulação_Funcionário_id_Func INTEGER NOT NULL,
  PRIMARY KEY (Voo_cod_voo, Tripulação_Funcionário_id_Func),
    FOREIGN KEY (Voo_cod_voo)
    REFERENCES Voo (cod_voo),
    FOREIGN KEY (Tripulação_Funcionário_id_Func)
    REFERENCES Tripulação (Funcionário_id_Func));


CREATE INDEX fk_Voo_has_Tripulação_Tripulação1_idx ON Tripulação_Voo (Tripulação_Funcionário_id_Func ASC) ;

CREATE INDEX fk_Voo_has_Tripulação_Voo1_idx ON Tripulação_Voo (Voo_cod_voo ASC) ;


-- -----------------------------------------------------
-- Table Trecho
-- -----------------------------------------------------
DROP TABLE IF EXISTS Trecho ;

CREATE TABLE IF NOT EXISTS Trecho (
  cod_trecho INTEGER NOT NULL,
  PRIMARY KEY (cod_trecho));

-- -----------------------------------------------------
-- Table Passageiro
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Passageiro (
  ID_pas INTEGER NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  milhas_totais INTEGER  NULL,
  nro_notas_fiscais INTEGER  NOT NULL,
  prim_nome VARCHAR(50) NOT NULL,
  sobrenome VARCHAR(100) NOT NULL,
  sexo VARCHAR(4) NOT NULL,
  data_nasc DATE NOT NULL,
  est_civil VARCHAR(45) NULL,
  RG INTEGER  NOT NULL,
  CPF INTEGER NOT NULL,
  nacionalidade VARCHAR(60) NOT NULL,
  Presencial_Funcionário_id_Func INTEGER NOT NULL,
  PRIMARY KEY (ID_pas),
    FOREIGN KEY (Presencial_Funcionário_id_Func)
    REFERENCES Presencial (Funcionário_id_Func)
);

CREATE UNIQUE INDEX ID_pas_UNIQUE ON Passageiro (ID_pas ASC) ;

CREATE UNIQUE INDEX RG_copy1_UNIQUE ON Passageiro (RG ASC) ;

CREATE UNIQUE INDEX CPF_UNIQUE ON Passageiro (CPF ASC) ;

CREATE INDEX fk_Passageiro_Presencial1_idx ON Passageiro (Presencial_Funcionário_id_Func ASC) ;


-- -----------------------------------------------------
-- Table Viagem
-- -----------------------------------------------------
DROP TABLE IF EXISTS Viagem ;

CREATE TABLE IF NOT EXISTS Viagem (
  cod_viagem INTEGER NOT NULL,
  Trecho_cod_trecho INTEGER NOT NULL,
  Passageiro_ID_pas INTEGER NOT NULL,
  PRIMARY KEY (cod_viagem),
    FOREIGN KEY (Trecho_cod_trecho)
    REFERENCES Trecho (cod_trecho),
    FOREIGN KEY (Passageiro_ID_pas)
    REFERENCES Passageiro (ID_pas)
);

CREATE UNIQUE INDEX cod_viagem_UNIQUE ON Viagem (cod_viagem ASC) ;

CREATE INDEX fk_Viagem_Trecho1_idx ON Viagem (Trecho_cod_trecho ASC) ;

CREATE INDEX fk_Viagem_Passageiro1_idx ON Viagem (Passageiro_ID_pas ASC) ;


-- -----------------------------------------------------
-- Table Bagagem
-- -----------------------------------------------------
DROP TABLE IF EXISTS Bagagem ;

CREATE TABLE IF NOT EXISTS Bagagem (
  cod_bagagem INTEGER NOT NULL,
  prioridade VARCHAR(45) NULL,
  tipo VARCHAR(45) NOT NULL,
  peso FLOAT NOT NULL,
  altura FLOAT NOT NULL,
  largura FLOAT NOT NULL,
  comprimento FLOAT NOT NULL,
  Presencial_Funcionário_id_Func INTEGER NOT NULL,
  Viagem_cod_viagem INTEGER NOT NULL,
  PRIMARY KEY (cod_bagagem),
    FOREIGN KEY (Presencial_Funcionário_id_Func)
    REFERENCES Presencial (Funcionário_id_Func),
    FOREIGN KEY (Viagem_cod_viagem)
    REFERENCES Viagem (cod_viagem)
);

CREATE UNIQUE INDEX cod_bagagem_UNIQUE ON Bagagem (cod_bagagem ASC) ;

CREATE INDEX fk_Bagagem_Presencial1_idx ON Bagagem (Presencial_Funcionário_id_Func ASC) ;

CREATE INDEX fk_Bagagem_Viagem1_idx ON Bagagem (Viagem_cod_viagem ASC) ;


-- -----------------------------------------------------
-- Table Responsáveis
-- -----------------------------------------------------
DROP TABLE IF EXISTS Responsáveis ;

CREATE TABLE IF NOT EXISTS Responsáveis (
  Passageiro_ID_pas INTEGER NOT NULL,
  Telefone VARCHAR(45) NOT NULL,
  prim_nome VARCHAR(50) NOT NULL,
  sobrenome VARCHAR(100) NOT NULL,
  PRIMARY KEY (Passageiro_ID_pas, Telefone),
    FOREIGN KEY (Passageiro_ID_pas)
    REFERENCES Passageiro (ID_pas));


CREATE UNIQUE INDEX Telefone_UNIQUE ON Responsáveis (Telefone ASC) ;


-- -----------------------------------------------------
-- Table Trecho_Voo
-- -----------------------------------------------------
DROP TABLE IF EXISTS Trecho_Voo ;

CREATE TABLE IF NOT EXISTS Trecho_Voo (
  Trecho_cod_trecho INTEGER NOT NULL,
  Voo_cod_voo INTEGER NOT NULL,
  ordem INTEGER NOT NULL,\
    FOREIGN KEY (Trecho_cod_trecho)
    REFERENCES Trecho (cod_trecho),
    FOREIGN KEY (Voo_cod_voo)
    REFERENCES Voo (cod_voo)
);

CREATE INDEX fk_Trecho_has_Voo_Voo1_idx ON Trecho_Voo (Voo_cod_voo ASC) ;

CREATE INDEX fk_Trecho_has_Voo_Trecho1_idx ON Trecho_Voo (Trecho_cod_trecho ASC) ;
