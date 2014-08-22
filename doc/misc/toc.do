.am H
.ie '\\$1'1' .tm .H1 \\n(H1 "\\$2" \\nP
.el .ie '\\$1'2' .tm .H2 \\n(H1.\\n(H2 "\\$2" \\nP
.el .ie '\\$1'3' .tm .H3 \\n(H1.\\n(H2.\\n(H3 "\\$2" \\nP
.el .ie '\\$1'4' .tm .H4 \\n(H1.\\n(H2.\\n(H3.\\n(H4 "\\$2" \\nP
..
.am aP
.tm .HA "\\$1" "\\$2"
..
