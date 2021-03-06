require_relative '../../helpers'

describe org.jrubyparser.ast.FCallNode do
  VERSIONS.each do |v|
#    it "parses a 0-arg method call sans parens +extra line [#{v}]" do
#      rparse("\nblock_given?\n", v).find_node(:fcall).tap do |call|
#        call.should have_name_and_position("block_given?", 1, 1, 1, 13)
#      end
#    end

    it "parses a 0-arg method call with parens [#{v}]" do
      rparse("puts()", v).find_node(:fcall).tap do |call|
        call.should have_name_and_position("puts", 0, 0, 0, 6)
        call.args_node.size.should == 0
      end
    end

    it "parses a 1-arg method call with parens [#{v}]" do
      rparse("puts(1)", v).find_node(:fcall).tap do |call|
        call.should have_name_and_position("puts", 0, 0, 0, 7)
        call.args_node.size.should == 1
      end
    end

    it "parses a 1-arg method call without parens [#{v}]" do
      rparse("puts 1", v).find_node(:fcall).tap do |call|
        call.should have_name_and_position("puts", 0, 0, 0, 6)
        call.args_node.size.should == 1
      end
    end

    it "parses a 2-arg method call with parens [#{v}]" do
      rparse("puts(1,2)", v).find_node(:fcall).tap do |call|
        call.should have_name_and_position("puts", 0, 0, 0, 9)
        call.args_node.size.should == 2
      end
    end

    it "parses a 2-arg method call without parens [#{v}]" do
      rparse("puts 1, 2", v).find_node(:fcall).tap do |call|
        call.should have_name_and_position("puts", 0, 0, 0, 9)
        call.args_node.size.should == 2
      end
    end

    it "parses an empty method with a block({}) [#{v}]" do
      parse("foo() {}", v).find_node(:fcall).tap do |call|
        call.should have_name_and_position("foo", 0, 0, 0, 8)
        call.iter_node.should have_position(0, 0, 6, 8)
      end
    end

    it "parses an empty method with a block(do...end) [#{v}]" do
      parse("foo() do\nend\n", v).find_node(:fcall).tap do |call|
        call.should have_name_and_position("foo", 0, 1, 0, 12)
        call.iter_node.should have_position(0, 1, 6, 12)
      end
    end

    it "parses an empty method with a block({}) +1 arg [#{v}]" do
      parse("foo() { |a| }", v).find_node(:fcall).tap do |call|
        call.should have_name_and_position("foo", 0, 0, 0, 13)
        call.iter_node.should have_position(0, 0, 6, 13)
        # FIXME: Need arg tests
      end
    end

    it "parses an empty method with a block(do...end) [#{v}]" do
      parse("foo() do |a|\nend\n", v).find_node(:fcall).tap do |call|
        call.should have_name_and_position("foo", 0, 1, 0, 16)
        call.iter_node.should have_position(0, 1, 6, 16)
        # FIXME: Need arg tests
      end
    end
  end
end
