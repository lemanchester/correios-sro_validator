require "correios/version"
module Correios

  # Algoritmo para cálculo do dígito verificador do número de registro:
  #  1. Aplicar os fatores de ponderação sobre os dígitos do número seqüencial do registro utilizando os seguintes algarismos: 8 6 4 2 3 5 9 7;
  #  2. Calcular a soma destes números;
  #  3. Dividir esta soma por 11;
  #  4. Caso o resto seja igual a 0 ou 1, utilizar como dígito de controle, respectivamente, 5 ou 0;
  #  5. Caso contrário, subtrair o resto de 11, sendo o algarismo obtido correspondente ao dígito verificador. EXEMPLO:
  #                Se o número seqüencial for 47312482, aplicando a fórmula teremos: (4*8) + (7*6) + (3*4) + (1*2) + (2*3) + (4*5) + (8*9) + (2*7) = 200 Continuando, 200 / 11 = 18 com resto = 2.
  #                O dígito verificador será dado por: DV = 11 - 2 = 9.
  #
  class SROValidator

    WEIGHTING_FACTORS = [8, 6, 4, 2, 3, 5, 9, 7]

    CONTROL_DIGIT = {
      0 => 5,
      1 => 0
    }

    attr_reader :sro

    def initialize(sro)
      @sro = sro
    end

    def valid?
      regexp_result = sro.match(/^[A-Z|a-z]{2}([0-9]{8})([0-9])BR$/)
      numbers = regexp_result.values_at(1).first
      verification = regexp_result.values_at(2).first.to_i

      array_of_numbers = numbers.split("").map(&:to_i)
      total = array_of_numbers.zip(WEIGHTING_FACTORS).map { |a| a.inject(:*) }.inject(:+)

      dig = total % 11

      result = CONTROL_DIGIT[dig] || (11-dig)
      result == verification
    end


  end
end
