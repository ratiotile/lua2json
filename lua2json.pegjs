// PEG.js grammar to generate parser

TopLevel
  =  __ head:Statement __
    tail:(Statement __)*
    {
      tail.map(function(ele){Object.assign(head, ele[0])})
      return head
    }

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
  / ArrayInitializer

Table
  = "{" __ inner:Statement __ "}"
    {return inner}
  / "{" __ head:Statement __
    tail:(Statement __)* "}"
    {
      tail.map(function(ele){Object.assign(head, ele[0])})
      return head
    }

ArrayInitializer
  = "{" __ item:Value
    tail:(ArraySeparator __ Value)* __ "}"
    {
      var head = [item]
      tail.map(function(ele){
        head.push(ele[2])
      })
      return head
    }

/** Basic Definitions **/

// Separator, Space
Zs = [\u0020\u00A0\u1680\u2000-\u200A\u202F\u205F\u3000]

ArraySeparator
  = ","

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
