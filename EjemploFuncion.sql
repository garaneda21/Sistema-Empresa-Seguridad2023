--estructura de un programa en postgreSQL PLpgSQL
do $$
declare
--variable
begin
raise notice 'HOLA MUNDO!!!';
end $$


do $$
declare
--variable
vMensaje VARCHAR(100);
begin
vMensaje:='Como estan';
raise notice 'HOLA MUNDO!!!';
raise notice 'Valor que tiene la variable vMensaje[%]',vMensaje;
end $$
