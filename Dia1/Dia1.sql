show databases;

create database Dia1_Mysql2;

use Dia1_Mysql2;

create table empleado (
    id int primary key,
    nombre varchar(50) not null,
    direccion varchar(50) not null,
    telefono varchar(20) not null,
    poblacion varchar(50) null,
    provincia varchar(30) not null,
    codigo_postal int not null,
    nif varchar(20) not null,
    numero_seguridad_social varchar(20) not null,
    tipo_empleado enum('ats', 'ats de zona', 'auxiliar de enfermería', 'celador', 'administrativo')
);

create table medico (
    id int not null primary key,
    nombre varchar(50) not null,
    direccion varchar(50) not null,
    telefono varchar(20) not null,
    poblacion varchar(50) null,
    provincia varchar(30) not null,
    codigo_postal int not null,
    nif varchar(20) not null,
    numero_seguridad_social varchar(20) not null,
    numero_colegiado varchar(20) null,
    tipo_medico enum('titular', 'interino', 'sustituto'),
    id_horario int not null
);

create table horario (
    id int primary key,
    id_medico int not null,
    dia_semana date not null,
    hora_inicio datetime not null,
    hora_fin datetime not null,
    foreign key (id_medico) references medico(id)
);

create table sustitucion (
    id int primary key,
    id_medico int not null,
    fecha_alta date not null,
    fecha_baja date not null,
    foreign key (id_medico) references medico(id)
);

create table paciente (
    id int primary key,
    nombre varchar(50) not null,
    direccion varchar(50) not null,
    telefono varchar(20) not null,
    codigo_postal int not null,
    nif varchar(20) not null,
    numero_seguridad_social varchar(20) not null,
    id_medico int not null,
    foreign key (id_medico) references medico(id)
);

create table vacaciones (
    id int primary key,
    id_medico int not null,
    id_empleado int not null,
    fecha_inicio date not null,
    fecha_fin date not null,
    tipo_vacaciones enum('planificadas', 'disfrutadas'),
    foreign key (id_medico) references medico(id),
    foreign key (id_empleado) references empleado(id)
);

show tables;

 ### 1. Número de pacientes atendidos por cada médico
select medico.nombre, count(paciente.id)
from medico
left join paciente on medico.id = paciente.id
group by medico.nombre;

### 2. Total de días de vacaciones planificadas y disfrutadas por cada empleado
select empleado.nombre, count(vacaciones.id)
from empleado 
left join vacaciones on empleado.id = vacaciones.id
where tipo_vacaciones = 'planificadas'
group by empleado.nombre;

### 3. Médicos con mayor cantidad de horas de consulta en la semana
select m.nombre as nombre_medico, sum(timestampdiff(hour, h.hora_inicio, h.hora_fin)) as horas_consulta_semana
from medico m
inner join horario h on m.id = h.id_medico
group by m.nombre
order by horas_consulta_semana desc;

### 4. Número de sustituciones realizadas por cada médico sustituto
select medico.nombre, count(sustitucion.id) as numero_sustituciones
from medico
left join sustitucion on medico.id = sustitucion.id_medico
where medico.tipo_medico = 'sustituto'
group by medico.id, medico.nombre
order by numero_sustituciones desc;


### 5. Número de médicos que están actualmente en sustitución
select count(distinct id_medico) as numero_medicos_sustitucion
from sustitucion;

### 6. Horas totales de consulta por médico por día de la semana
select medico.nombre, horario.dia_semana, sum(timestampdiff(hour, horario.hora_inicio, horario.hora_fin)) as horas_totales_consulta
from medico
inner join horario on medico.id = horario.id_medico
group by medico.id, medico.nombre, horario.dia_semana
order by medico.nombre, horario.dia_semana;

### 7. Médico con mayor cantidad de pacientes asignados
select medico.nombre, count(paciente.id) as cantidad_pacientes_asignados
from medico
left join paciente on medico.id = paciente.id_medico
group by medico.id, medico.nombre
order by cantidad_pacientes_asignados desc
limit 1;

### 8. Empleados con más de 10 días de vacaciones disfrutadas
select empleado.nombre, count(vacaciones.id) as dias_vacaciones_disfrutadas
from empleado
inner join vacaciones on empleado.id = vacaciones.id_person
where vacaciones.tipo_vacaciones = 'disfrutadas'
group by empleado.id, empleado.nombre
having dias_vacaciones_disfrutadas > 10
order by dias_vacaciones_disfrutadas desc;

### 9. Médicos que actualmente están realizando una sustitución

### 10. Promedio de horas de consulta por médico por día de la semana
select medico.nombre, horario.dia_semana, avg(timestampdiff(hour, horario.hora_inicio, horario.hora_fin)) as promedio_horas_consulta
from medico
inner join horario on medico.id = horario.id_medico
group by medico.id, medico.nombre, horario.dia_semana
order by medico.nombre, horario.dia_semana;


select * from empleado;
select * from medico;
select * from horario;
select * from sustitucion;
select * from paciente;
select * from vacaciones;

-- Desarrollado por Hernan Mendez Guerrero / 1101685607