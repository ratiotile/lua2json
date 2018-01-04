UnitData
  = __ value:Statement __ {return value}

Identifier
  = chars:[A-z_]+ {return chars.join("");}

Number
  = digits:[-\.0-9]+ {return Number(digits.join(""));}

Statement
  = _ name:Identifier _ "=" _ value:Value _
    { var obj = {};
      obj[name] = value;
      return obj;
    }

Value
  = Identifier
  / Table
  / Number

Table
  = "{" __ inner:Statement __ "}"
    {return inner}
//  / "{" __ inner:Statement __ inner2:Statement __"}"
 //   {return Object.assign(inner, inner2)}
  / "{" __ head:Statement __
    tail:(Statement __)* "}"
    {
      tail.map(function(ele){Object.assign(head, ele[0])})
      return head
    }

/** Basic Definitions **/

// Separator, Space
Zs = [\u0020\u00A0\u1680\u2000-\u200A\u202F\u205F\u3000]

WhiteSpace "whitespace"
  = "\t"
  / "\v"
  / "\f"
  / " "
  / "\u00A0"
  / "\uFEFF"
  / Zs

_
  = (WhiteSpace)*

__
  = (WhiteSpace / Comment / LineTerminatorSequence)*

LineTerminator
  = [\n\r\u2028\u2029]

LineTerminatorSequence "end of line"
  = "\n"
  / "\r\n"
  / "\r"
  / "\u2028"
  / "\u2029"

Comment
  = "#" (!LineTerminator .)*
