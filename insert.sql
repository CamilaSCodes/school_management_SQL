INSERT INTO alunos (cd_aluno_al, nm_aluno_al, dt_nascimento_al, tp_sexo_al, de_endereco_al, nu_endereco_al, nm_bairro_al, nm_cidade_al, nu_cep_al, de_email_al, nu_telefone_al)
VALUES
    (1, 'João Silva', '2000-05-15', 'M', 'Rua A, 123', '12345', 'Centro', 'Fortaleza', '60000-000', 'joao@uece.com', '85911111111'),
    (2, 'Maria Santos', '2001-08-20', 'F', 'Rua B, 456', '54321', 'Bela Vista', 'Crato', '63100-000', 'maria@uece.com', '88922222222'),
    (3, 'Pedro Oliveira', '2002-03-10', 'M', 'Av. C, 789', '67890', 'Industrial', 'Juazeiro', '63000-000', 'pedro@email.com', '88733333333'),
    (4, 'Ana Costa', '2000-12-05', 'F', 'Rua D, 321', '13579', 'Jardim', 'Fortaleza', '60100-000', 'ana@email.com', '85944444444'),
    (5, 'Carlos Oliveira', '2001-10-25', 'M', 'Travessa E, 456', '98765', 'Centro', 'Sobral', '62000-000', 'carlos@uece.com', '88855555555'),
    (6, 'Mariana Lima', '2002-07-18', 'F', 'Rua F, 654', '54321', 'Vila Nova', 'Fortaleza', '60200-000', 'mariana@email.com', '85966666666');

INSERT INTO professores (cd_professor_pr, nm_professor_pr, dt_nascimento_pr, tp_sexo_pr, de_email_pr, nu_telefone_pr)
VALUES
    (1, 'José Leal', '1985-03-25', 'M', 'joseleal@uece.com', '88777777777'),
    (2, 'Ana Oliveira', '1980-09-12', 'F', 'anaoliveira@email.com', ''),
    (3, 'Felipe Santos', '1990-07-08', 'M', 'felipesantos@uece.com', '88912345678'),
    (4, 'Carla Silva', '1987-11-30', 'F', 'carlasilva@email.com', '8899876543'),
    (5, 'Gabriel Costa', '1982-05-15', 'M', 'gabrielcosta@email.com', ''),
    (6, 'Marta Mendes', '1983-08-20', 'F', 'martamendes@email.com', '88995115951');

INSERT INTO disciplinas (cd_disciplina_di, nm_disciplina_di, cd_professor_pr)
VALUES
    (1, 'Banco de Dados', 1),
    (2, 'Cálculo', 2),
    (3, 'Física', 3),
    (4, 'Lógica de Programação', 4),
    (5, 'Computação Gráfica', 5),
    (6, 'Estrutura de Dados', 6);

INSERT INTO matriculas (cd_matricula_ma, dt_matricula_ma, cd_aluno_al, cd_disciplina_di)
VALUES
    (1, '2023-01-15', 1, 1),
    (2, '2021-01-20', 2, 2),
    (3, '2022-02-10', 3, 3),
    (4, '2021-06-01', 4, 4),
    (5, '2023-03-05', 5, 5),
    (6, '2023-03-10', 6, 6);
