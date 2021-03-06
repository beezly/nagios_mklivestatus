# This class is used to make a logical "NOT" operator for the filter expression.
#
# Author::    Esco-lan Team  (mailto:team@esco-lan.org)
# Copyright:: Copyright (c) 2012 GIP RECIA
# License::   General Public Licence
class Nagios::MkLiveStatus::Filter::Negate < Nagios::MkLiveStatus::Filter
  
  include Nagios::MkLiveStatus
  
  #
  # Create a new "Not" operator for the expression.
  #
  # Those expressions must be of type Nagios::MkLiveStatus::Filter
  #
  def initialize(expr)
    if not expr.is_a? Nagios::MkLiveStatus::Filter
      raise QueryException.new("The operand for a NEGATE expression must be a filter expression.")
    end
    
    @expression = expr
    
  end
  
  #
  # Return the expression under the "Negate". It's used by 
  # the to_s method in order to remove the overflow of Negate expression.  
  #
  def get_expression
    return @expression
  end
  
  #
  # Convert the current "Negate" expression into a nagios query string.
  #  Filter: ...
  #  Negate:
  #
  # If the sub expression is also a Negate, it returns the sub-sub expression without negating it.
  #
  def to_s
    if @expression.is_a? Nagios::MkLiveStatus::Filter::Negate
      return @expression.get_expression.to_s
    else
      negate_arr = []
      negate_arr.push @expression.to_s
      negate_arr.push "Negate: "
      return negate_arr.join("\n")
    end
  end
end