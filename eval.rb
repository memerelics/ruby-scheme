require 'minitest/spec'
require 'minitest/autorun'

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

describe "_eval" do
  it { _eval("1").must_equal "1" }
  it { _eval("\"hoge\"").must_equal "\"hoge\"" }
  it { _eval("(+ 1 2)").must_equal 3 }
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

describe "self_evalating?" do
  it { self_evalating?("1").must_equal true }
  it { self_evalating?("99999999").must_equal true }
  it { self_evalating?("\"hoge\"").must_equal true }
  it { self_evalating?("\"\"").must_equal true }
  it { self_evalating?("(+ 1 2)").must_equal false }
end

def s_expression?(exp)
  if exp =~ /^\(.*\)$/
    true
  else
    false
  end
end

describe "s_expression?" do
  it { s_expression?("(+ 1 2)").must_equal true }
  it { s_expression?("(hoge fuga piyo)").must_equal true }
  it { s_expression?("1").must_equal false }
end

def _apply(procedure, arguments)
  if primitive_procedure?(procedure)
    apply_primitive_procedure(procedure, arguments)
  end
end

describe "_apply" do
  describe "primitive procedures" do
    it { _apply("+", ["1", "2"]).must_equal 3 }
  end
end


def extract(s_exp)
  s_exp.gsub(/\((.*)\)/) { $1 }.split
end

# TODO: (hoge (piyo 1) 2) style expression
describe "extract" do
  it { extract("(+ 1 2)").must_equal ["+", "1", "2"] }
end

def operator(list); list.first; end
def operands(list); list[1..-1]; end

describe "operator/operands" do
  it { operator(["+", "1", "2"]).must_equal "+" }
  it { operands(["+", "1", "2"]).must_equal ["1", "2"] }
end

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

describe "apply_primitive_procedure" do
  it { apply_primitive_procedure("+", ["1", "2"]).must_equal 3 }
end

