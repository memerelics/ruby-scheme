# 前提をなるべく排除して考える
#   * 1行1式
#   * 前置記法(最初が演算子, 残りが非演算子)
#   * 区切りは空白文字
# 例: + 1 2 を評価すると3となる.

module Anfinsen
  module Basic

    # Ruby自身のevalをaliasで待避
    alias underlying_eval eval

    PRIMITIVES = ['+', '-', '*']

    def parse(exp)
      exp.split(' ')
    end

    def apply_primitive(operator, operands)
      case operator
      when '+', '-', '*'
        underlying_eval(operands.join(operator))
      end
    end

    # evalは式と環境(変数から値への写像)を受け取り, 評価した結果を返す.
    def eval(exp, env={})
      raise 'invalid env' unless env.is_a? Hash
      tokens = parse(exp)
      operator, operands = tokens.first, tokens.drop(1)
      return apply_primitive(operator, operands) if PRIMITIVES.include?(operator)
    end

  end
end
