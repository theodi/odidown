# encoding: UTF-8

require "test_helper"

class MathMLTest < Test::Unit::TestCase

  test "mathml area of circle" do
    mathml = <<-EOF
    <math xmlns="http://www.w3.org/1998/Math/MathML">
      <mi>π</mi>
      <mo>⁢</mo>
      <msup>
        <mi>r</mi>
        <mn>2</mn>
      </msup>
    </math>
    EOF
    assert_equal w(mathml), w(Govspeak::HtmlSanitizer.new(mathml).sanitize)
  end

  test "mathml quadratic equation" do
    mathml = <<-EOF
    <math mode="display" xmlns="http://www.w3.org/1998/Math/MathML">
      <mrow>
        <mi>x</mi>
        <mo>=</mo>
        <mfrac>
          <mrow>
            <mo form="prefix">−</mo>
            <mi>b</mi>
            <mo>±</mo>
            <msqrt>
              <msup>
                <mi>b</mi>
                <mn>2</mn>
              </msup>
              <mo>−</mo>
              <mn>4</mn>
              <mo>⁢</mo>
              <mi>a</mi>
              <mo>⁢</mo>
              <mi>c</mi>
            </msqrt>
          </mrow>
          <mrow>
            <mn>2</mn>
            <mo>⁢</mo>
            <mi>a</mi>
          </mrow>
        </mfrac>
      </mrow>
      <annotation encoding="TeX">
         x=\\frac{-b\\pm\\sqrt{b^2-4ac}}{2a}
      </annotation>
      <annotation encoding="StarMath 5.0">
         x={-b plusminus sqrt {b^2 - 4 ac}} over {2 a}
      </annotation>
    </math>
    EOF
    assert_equal w(mathml), w(Govspeak::HtmlSanitizer.new(mathml).sanitize)
  end

  def w(str)
    str.gsub(/\>\s*/, ">").gsub(/\s*\</, "<")
  end
    

end
