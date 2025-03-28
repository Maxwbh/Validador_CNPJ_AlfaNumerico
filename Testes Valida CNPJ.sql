-- Testes
begin
  -- CNPJ numérico válido tradicional
  dbms_output.put_line('11.444.777/0001-61: ' || case when valida_cnpj_alfanumerico('11.444.777/0001-61') then 'Válido' else 'Inválido' end);

  -- CNPJ alfanumérico inválido
  dbms_output.put_line('AB123456789012: ' || case when valida_cnpj_alfanumerico('AB.123.456/7890-12') then 'Válido' else 'Inválido' end);

  -- CNPJ alfanumérico válido
  dbms_output.put_line('AA111111111171: ' || case when valida_cnpj_alfanumerico('AA111111111171') then 'Válido' else 'Inválido' end);
end;
