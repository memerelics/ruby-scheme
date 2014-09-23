require 'spec_helper'

describe "_eval" do
  it { _eval("1").must_equal "1" }
  it { _eval("\"hoge\"").must_equal "\"hoge\"" }
  it { _eval("(+ 1 2)").must_equal 3 }
end

describe "self_evalating?" do
  it { self_evalating?("1").must_equal true }
  it { self_evalating?("99999999").must_equal true }
  it { self_evalating?("\"hoge\"").must_equal true }
  it { self_evalating?("\"\"").must_equal true }
  it { self_evalating?("(+ 1 2)").must_equal false }
end

describe "s_expression?" do
  it { s_expression?("(+ 1 2)").must_equal true }
  it { s_expression?("(hoge fuga piyo)").must_equal true }
  it { s_expression?("1").must_equal false }
end

describe "_apply" do
  describe "primitive procedures" do
    it { _apply("+", ["1", "2"]).must_equal 3 }
  end
end

# TODO: (hoge (piyo 1) 2) style expression
describe "extract" do
  it { extract("(+ 1 2)").must_equal ["+", "1", "2"] }
end

describe "operator/operands" do
  it { operator(["+", "1", "2"]).must_equal "+" }
  it { operands(["+", "1", "2"]).must_equal ["1", "2"] }
end

describe "apply_primitive_procedure" do
  it { apply_primitive_procedure("+", ["1", "2"]).must_equal 3 }
end

