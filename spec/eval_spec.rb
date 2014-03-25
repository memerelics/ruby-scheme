require 'spec_helper'

describe "_eval" do
  it { _eval("1").should eq "1" }
  it { _eval("\"hoge\"").should eq "\"hoge\"" }
  it { _eval("(+ 1 2)").should eq 3 }
end

describe "self_evalating?" do
  it { self_evalating?("1").should eq true }
  it { self_evalating?("99999999").should eq true }
  it { self_evalating?("\"hoge\"").should eq true }
  it { self_evalating?("\"\"").should eq true }
  it { self_evalating?("(+ 1 2)").should eq false }
end

describe "s_expression?" do
  it { s_expression?("(+ 1 2)").should eq true }
  it { s_expression?("(hoge fuga piyo)").should eq true }
  it { s_expression?("1").should eq false }
end

describe "_apply" do
  describe "primitive procedures" do
    it { _apply("+", ["1", "2"]).should eq 3 }
  end
end

# TODO: (hoge (piyo 1) 2) style expression
describe "extract" do
  it { extract("(+ 1 2)").should eq ["+", "1", "2"] }
end

describe "operator/operands" do
  it { operator(["+", "1", "2"]).should eq "+" }
  it { operands(["+", "1", "2"]).should eq ["1", "2"] }
end

describe "apply_primitive_procedure" do
  it { apply_primitive_procedure("+", ["1", "2"]).should eq 3 }
end

