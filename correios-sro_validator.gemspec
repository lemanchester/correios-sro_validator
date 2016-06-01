# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'correios/sro_validator'

Gem::Specification.new do |spec|
  spec.name          = "correios-sro_validator"
  spec.version       = Correios::SROValidator::VERSION
  spec.authors       = ["Lennon Manchester"]
  spec.email         = ["lennon.manchester@walmart.com"]

  spec.summary       = %q{Validates the SRO using verification digit}
  spec.description   = %q{Validates the SRO (Sistema de Rastreamento de Objetos dos Correios) structure to guarantee it's a Correios SRO.}
  spec.homepage      = "http://www.correios.com.br/para-sua-empresa/servicos-para-o-seu-contrato/guias/enderecamento/arquivos/guia_tecnico_encomendas.pdf"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
