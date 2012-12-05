# -*- coding: utf-8 -*-

require_relative 'HanziAnalyzer'

if ARGV.size < 2
  puts "# Error en parametros de entrada:"
  puts "# ruby #{File.basename(__FILE__)} hanzifile textfile [outputfile]"
  exit -1
end

# Recibe argumentos de entrada
file_in   = ARGV[0]
file_text = ARGV[1]
file_out  = ARGV[2].nil? ? "output.yml" : ARGV[2]

if !File.file?(ARGV[0]) || !File.file?(ARGV[1])
  puts "# Error: No existen ficheros indicados"
  exit -1
end

# Carga hanzis a contabilizar
HanziAnalyzer::load file_in

# Analiza fichero de texto
HanziAnalyzer::analyze file_text

# Genera salida
HanziAnalyzer::save file_out
