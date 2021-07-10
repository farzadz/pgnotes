CREATE TABLE IF NOT EXISTS people
(
    id
        bigint,
    name
        text,
    unique_id
        uuid
);
INSERT INTO people
SELECT generate_series(1, 100),
       get_random_name(),
       uuid_generate_v4()
           ```
Where ` get_random_number ` is defined like:

``` sql
CREATE
    OR REPLACE FUNCTION random_between(low INT, high INT)
    RETURNS INT AS
$$
BEGIN
    RETURN floor(random() * (high - low + 1) + low);
END;
$$
    language 'plpgsql' STRICT;


CREATE
    OR REPLACE FUNCTION get_random_name()
    RETURNS TEXT AS
$body$
declare
    arr1 text[] := array ['Aaren','Aarika','Abagael','Abagail','Abbe','Abbey','Abbi','Abbie','Abby','Abbye','Abigael','Abigail','Abigale','Abra','Ada','Adah','Adaline','Adan','Adara','Adda','Addi','Addia','Addie','Addy','Adel','Adela'];
    arr2
         text[] := array ['Katleen','Katlin','Kato','Katonah','Katrina','Katrine','Katrinka','Katsuyama','Katt','Katti','Kattie','Katuscha','Katusha','Katushka','Katy','Katya','Katz','Katzen','Katzir','Katzman','Kauffman'];
begin
    RETURN arr1[random_between(1, array_upper(arr1, 1))] || ' ' || arr2[random_between(1, array_upper(arr2, 1))];
end;
$body$
    language 'plpgsql' STRICT;

CREATE
    OR REPLACE FUNCTION get_random_names(num int)
    RETURNS TABLE
            (
                full_name text
            )
AS
$$
declare
    t int;
BEGIN
    RETURN QUERY SELECT n.name FROM (SELECT get_random_name() AS name, generate_series(1, num) AS idx) AS n;
END;
$$
    language 'plpgsql' STRICT;