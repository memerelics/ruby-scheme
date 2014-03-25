def _eval(exp, env=nil)
  if self_evalating?(exp)
    exp
  elsif s_expression?(exp)
    list = extract(exp)
    _apply(operator(list), operands(list))
  else
    raise
  end
end

def self_evalating?(exp)
  case exp
  when /^\d+$/ # Integer literal
    true
  when /^\".*\"$/ # String literal
    true
  else
    false
  end
end

def s_expression?(exp)
  if exp =~ /^\(.*\)$/
    true
  else
    false
  end
end

def _apply(procedure, arguments)
  if primitive_procedure?(procedure)
    apply_primitive_procedure(procedure, arguments)
  end
end


def extract(s_exp)
  s_exp.gsub(/\((.*)\)/) { $1 }.split
end

def operator(list); list.first; end
def operands(list); list[1..-1]; end

def primitive_procedure?(procedure)
  ["+", "-", "*", "/"].include?(procedure)
end

def apply_primitive_procedure(procedure, arguments)
  case procedure
  when "+","-","*","/"
    # infix notation operators
    eval arguments.join(procedure)
  else
    # eval by underlying Ruby
    eval "#{procedure}(#{arguments.join(',')})"
  end
end
