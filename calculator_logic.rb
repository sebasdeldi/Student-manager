class Calculator

  def initialize (n,g)  
    @grades = n.split ","
    @perc = g.split ","
    @op =[]
    @r = 0
    @needed = 0
    printer
  end

  def grades
    @grades
  end

  def perc
    @perc
  end

  def op
    @op
  end

  def r
    @r
  end

  def convertor
    @perc = @perc.collect { |n| n.to_f }
    @perc = @perc.collect { |n| n / 100 }
    @grades = @grades.collect { |n| n.to_f }
  end

  def calculate

    @op = @perc.zip(@grades).map {|a| a.inject(:*)}


    @r = @op.inject{|sum,x| sum + x }
  end

  def printer
    convertor
    puts "#{grades}"
    puts "#{perc}"
    calculate
    puts "#{op}"

    if @perc.inject{|sum,x| sum + x } == 100
      
      if @r > 5 || @r < 0
        puts "Tu input es incorrecto"
      else
        puts "Tu nota final es #{r}"
      end
    else
      acum = @r
      perc_rest = 100 - (@perc.inject{|sum,x| sum + x } * 100)

      if @r > 5 || @r < 0
        puts "Tu input es incorrecto"
      else
        @needed = ((3-acum) / (perc_rest / 100) )
        puts "Necesitas #{@needed} en el #{perc_rest} % restante"
      end
    end
    

    
  end
end

