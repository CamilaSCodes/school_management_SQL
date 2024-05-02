CREATE TABLE alunos (
cd_aluno_al INTEGER PRIMARY KEY,
nm_aluno_al VARCHAR(100),
dt_nascimento_al DATE,
tp_sexo_al VARCHAR(1),
de_endereco_al VARCHAR(100),
nu_endereco_al VARCHAR(100),
nm_bairro_al VARCHAR(100),
nm_cidade_al VARCHAR(100),
nu_cep_al VARCHAR(100),
de_email_al VARCHAR(100),
nu_telefone_al VARCHAR(100)
)

CREATE TABLE disciplinas (
cd_disciplina_di INTEGER PRIMARY KEY,
nm_disciplina_di VARCHAR(100),
cd_professor_pr INTEGER
)

CREATE TABLE professores (
cd_professor_pr INTEGER PRIMARY KEY,
nm_professor_pr VARCHAR(100),
dt_nascimento_pr DATE,
tp_sexo_pr VARCHAR(1),
de_email_pr VARCHAR(100),
nu_telefone_pr VARCHAR(100)
)

CREATE TABLE matriculas (
cd_matricula_ma INTEGER PRIMARY KEY,
dt_matricula_ma DATE,
cd_aluno_al INTEGER,
cd_disciplina_di INTEGER,
FOREIGN KEY(cd_aluno_al) REFERENCES alunos (cd_aluno_al),
FOREIGN KEY(cd_disciplina_di) REFERENCES disciplinas (cd_disciplina_di)
)

ALTER TABLE disciplinas ADD FOREIGN KEY(cd_professor_pr) REFERENCES professores (cd_professor_pr)