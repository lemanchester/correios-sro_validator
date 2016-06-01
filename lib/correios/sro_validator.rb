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

    attr_reader :sro, :numbers, :verification_digit

    def initialize(sro)
      @sro = sro
      @sro =~ /^[A-Z|a-z]{2}([0-9]{8})([0-9])BR$/
      @numbers = $1
      @verification_digit = $2.to_i
    end

    def valid?
      result == verification_digit
    end

    private

    def result
      CONTROL_DIGIT[mod] || (11-mod)
    end

    def mod
      weighted_mean % 11
    end

    def weighted_mean
      sro_array.zip(WEIGHTING_FACTORS).map { |a| a.inject(:*) }.inject(:+)
    end

    def sro_array
      numbers.split("").map(&:to_i)
    end

  end
end
