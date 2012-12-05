# -*- coding: utf-8 -*-

module HanziAnalyzer
  require 'yaml'      
  # Caracteres a omitir
  INVALID_CHARACTERS = "|ǚǜ（）：。？★√×！℃“”；(!)．:、，*#ēāīōūǎěǐǒǔàèìòùáéíóúa-zA-Z0-9-\r\n.:\'\"\t "
  @@hanzis = Hash.new # Hanzis a analizar

  #-------------------------------------------------------------------------- 
  # Crea un Hash de hanzis con los caracteres contenidos en el
  # archivo que se usara para analizar los siguientes textos.
  #--------------------------------------------------------------------------
  def load filename = "input.txt"
    readfile(filename).each do |x|
      @@hanzis[x.to_sym] = 0 if @@hanzis[x.to_sym].nil?
    end
  end 

  #--------------------------------------------------------------------------
  # Guarda un fichero con el numero de apariciones de los caracteres 
  # del Hash hanzis en el fichero analizado.
  #f.puts arr#@@hanzis.to_yaml
  #--------------------------------------------------------------------------
  def save filename = "output.yml"
    
    return if @@hanzis.empty?
    
    arr = @@hanzis.sort {|x,y| x[1] <=> y[1]}
    
    f = File.new filename, "w"    
    until arr.empty?
      column = 0
      actual = arr.last[1]
      f.print "\nCon #{actual} apariciones:\n"
      while !arr.empty? && actual == arr.last[1]
        h = arr.pop
        if column >= 50
          column = 0
          f.print "\n"
        end
        f.print "#{h[0] }"
        column = column + 1        
      end
      f.print "\n"
    end 
    f.close
  end

  #--------------------------------------------------------------------------
  # Analiza el fichero contando el numero de repeticiones de los hanzis
  # que estan contenidos en el Hash.
  #--------------------------------------------------------------------------
  def analyze filename = "input_text.txt"
    return if @@hanzis.empty?
    readfile(filename).each do |x|
      @@hanzis[x.to_sym] = 
        @@hanzis[x.to_sym] + 1 unless @@hanzis[x.to_sym].nil?
    end
  end

  private
  #--------------------------------------------------------------------------
  # Lee un fichero y devuelve sus caracteres en un array.
  #--------------------------------------------------------------------------
  def readfile filename
    arr = Array.new
    File.open(filename, "r") do |file|
      file.each do |line|
        line.delete! (INVALID_CHARACTERS)
        line.split("").each do |h|
          arr << h
        end
      end 
    end 
    arr   
  end

  module_function :load
  module_function :save
  module_function :analyze
  module_function :readfile

end # module
