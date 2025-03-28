
create or replace function valida_cnpj_alfanumerico(p_cnpj in varchar2) return boolean is
  -- Variável para armazenar o CNPJ sem formatação e em maiúsculas
  v_cnpj_clean varchar2(14);

  -- Variáveis para o cálculo dos dígitos verificadores
  v_soma            number := 0;
  v_dv1             number;
  v_dv2             number;
  v_valor_caractere number;

  -- Vetores de pesos conforme a especificação:
  -- Para o 1º dígito: 5,4,3,2,9,8,7,6,5,4,3,2
  -- Para o 2º dígito: 6,5,4,3,2,9,8,7,6,5,4,3 e, para o 1º DV, peso 2
  type t_pesos is varray(13) of number;
  v_pesos_dv1 t_pesos := t_pesos(5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
  v_pesos_dv2 t_pesos := t_pesos(6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);

  -- Função interna para converter um caractere (dígito ou letra) para seu valor numérico (ASCII - 48)
  function get_valor_ascii(p_char in varchar2) return number is
  begin
    return ascii(p_char) - 48;
  end;

begin
  -- Retorna FALSE se a entrada for nula
  if p_cnpj is null then
    return false;
  end if;

  -- Remove caracteres de formatação (qualquer coisa que não seja número ou letra) e converte para maiúsculas
  v_cnpj_clean := upper(regexp_replace(p_cnpj, '[^0-9A-Z]', ''));

  -- Verifica se o CNPJ possui exatamente 14 caracteres
  if length(v_cnpj_clean) != 14 then
    return false;
  end if;

  -- Valida o formato: 12 caracteres alfanuméricos seguidos de 2 dígitos numéricos
  if not regexp_like(v_cnpj_clean, '^[0-9A-Z]{12}[0-9]{2}$') then
    return false;
  end if;

  -- Rejeita sequência em que todos os 14 caracteres sejam iguais
  if v_cnpj_clean = rpad(substr(v_cnpj_clean, 1, 1), 14, substr(v_cnpj_clean, 1, 1)) then
    return false;
  end if;

  -----------------------------------------------------------
  -- Cálculo do 1º dígito verificador (DV1)
  -----------------------------------------------------------
  v_soma := 0;
  for i in 1 .. 12 loop
    v_valor_caractere := get_valor_ascii(substr(v_cnpj_clean, i, 1));
    v_soma            := v_soma + (v_valor_caractere * v_pesos_dv1(i));
  end loop;
  v_dv1 := 11 - mod(v_soma, 11);
  if v_dv1 >= 10 then
    v_dv1 := 0;
  end if;

  -----------------------------------------------------------
  -- Cálculo do 2º dígito verificador (DV2)
  -----------------------------------------------------------
  v_soma := 0;
  for i in 1 .. 12 loop
    v_valor_caractere := get_valor_ascii(substr(v_cnpj_clean, i, 1));
    v_soma            := v_soma + (v_valor_caractere * v_pesos_dv2(i));
  end loop;
  -- Incorpora o 1º dígito com peso 2 (posição 13 do vetor v_pesos_dv2)
  v_soma := v_soma + (v_dv1 * v_pesos_dv2(13));
  v_dv2  := 11 - mod(v_soma, 11);
  if v_dv2 >= 10 then
    v_dv2 := 0;
  end if;

  -----------------------------------------------------------
  -- Validação final: os dígitos calculados devem coincidir com os informados
  -----------------------------------------------------------
  dbms_output.put_line('Digitos Calculados : ' || v_dv1 || v_dv2);
  if to_number(substr(v_cnpj_clean, 13, 1)) = v_dv1 and to_number(substr(v_cnpj_clean, 14, 1)) = v_dv2 then
    return true;
  else
    return false;
  end if;

exception
  when others then
    return false;
end valida_cnpj_alfanumerico;
