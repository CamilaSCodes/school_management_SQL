/* Selects all students */
SELECT * FROM alunos;

/* Counts the number of distinct enrollments */
SELECT 
   COUNT(DISTINCT cd_matricula_ma) 
FROM 
   matriculas;

/* Counts the number of distinct students */
SELECT 
   COUNT(DISTINCT cd_aluno_al) 
FROM 
   alunos;

/* Counting students per city */
SELECT
	nm_cidade_al,
	COUNT (nm_cidade_al)
FROM
	alunos
GROUP BY
	nm_cidade_al;

/* Students under 20 years old */
SELECT
	nm_aluno_al, dt_nascimento_al
FROM
	alunos
WHERE
	date_part('Year', age(CURRENT_DATE,dt_nascimento_al))<20;
	
/* Relationship between students, enrollments, and courses */
SELECT
	nm_aluno_al, nm_disciplina_di
FROM
	matriculas
INNER JOIN alunos
	ON alunos.cd_aluno_al = matriculas.cd_aluno_al
INNER JOIN disciplinas
	ON disciplinas.cd_disciplina_di = matriculas.cd_disciplina_di;

/* Enrollments made between January 1, 2021, and June 30, 2021 */
SELECT
	cd_matricula_ma, nm_aluno_al, nm_disciplina_di, dt_matricula_ma
FROM
	matriculas
INNER JOIN alunos
	ON alunos.cd_aluno_al = matriculas.cd_aluno_al
INNER JOIN disciplinas
	ON disciplinas.cd_disciplina_di = matriculas.cd_disciplina_di
WHERE dt_matricula_ma BETWEEN '2021-01-01' AND '2021-06-30';

/* Relationship between courses and professors */
SELECT
	nm_professor_pr, nm_disciplina_di
FROM
	disciplinas
INNER JOIN professores
	ON professores.cd_professor_pr = disciplinas.cd_professor_pr;
	
/* Female professors */
SELECT
	nm_professor_pr
FROM
	professores
WHERE
	tp_sexo_pr='F';

/* Students with phone numbers starting with '85' */
SELECT
	nm_aluno_al, nu_telefone_al
FROM
	alunos
WHERE
	nu_telefone_al ilike '85%';
	
/* Average age of students */
SELECT
	AVG(date_part('Year', age(CURRENT_DATE,dt_nascimento_al)))
FROM
	alunos;
	
/* Counts the number of times the course 'Database' appears in the enrollments */
SELECT
	COUNT(nm_disciplina_di)
FROM
	matriculas
INNER JOIN disciplinas
	ON disciplinas.cd_disciplina_di = matriculas.cd_disciplina_di
WHERE
	nm_disciplina_di ilike 'Banco de Dados';

/* Professors older than the average */
SELECT 
	nm_professor_pr
FROM 
	professores 
WHERE 
	date_part('Year', age(CURRENT_DATE,dt_nascimento_pr)) > (SELECT AVG(date_part('Year', age(CURRENT_DATE,dt_nascimento_pr))) FROM professores);
	
/* Selects students whose emails end with '@uece.com' */
SELECT
	nm_aluno_al, de_email_al
FROM
	alunos
WHERE
	de_email_al ilike '%uece.com';
	
/* Students without enrollments */
SELECT 
	nm_aluno_al, date_part('Year', age(CURRENT_DATE,dt_nascimento_al)) AS idade
FROM 
	alunos 
WHERE NOT EXISTS (SELECT cd_aluno_al FROM matriculas WHERE alunos.cd_aluno_al = matriculas.cd_aluno_al);

/* Professors without phone numbers */
SELECT
	nm_professor_pr
FROM
	professores
WHERE
	nu_telefone_pr = '';
	
/* Professors of students born in 2000 or 2001 */
SELECT DISTINCT 
	professores.nm_professor_pr 
FROM 
	matriculas 
JOIN 
	disciplinas USING (cd_disciplina_di) 
JOIN 
	professores USING(cd_professor_pr) 
JOIN 
	alunos USING(cd_aluno_al) 
WHERE dt_nascimento_al BETWEEN '2000-01-01' AND '2001-12-31';

/* Professors with 'Leal' in the name */
SELECT
	nm_professor_pr
FROM
	professores
WHERE
	nm_professor_pr ilike '%Leal%';
	
/* Count of disciplines per student */
SELECT
	nm_aluno_al, COUNT(nm_disciplina_di)
FROM
	matriculas
INNER JOIN alunos
	ON alunos.cd_aluno_al = matriculas.cd_aluno_al
INNER JOIN disciplinas
	ON disciplinas.cd_disciplina_di = matriculas.cd_disciplina_di
GROUP BY
	nm_aluno_al;

/* Check if students live in Crato */
SELECT
	nm_aluno_al,
	CASE 
		WHEN nm_cidade_al ilike 'Crato' THEN 'SIM'
		ELSE 'NÃO' 
	END as Mora_em_Crato
FROM
	alunos;