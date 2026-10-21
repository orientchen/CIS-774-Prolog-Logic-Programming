% Sample prolog code

% Facts

% Our first group of persons are students
% Each person is identified by a unique ID
person(123,john).
person(234,andrew).
person(456,megan).
person(678,jeremy).
person(990,thor).
person(505,heather).
person(135,marmaduke).
person(246,scoobydo).

% Our second group of persons are instructors
person(222,erica).
person(111,stu).
person(333,jdc).

% Classes also are identified by unique IDs
class(cis774,programminglanguages).
class(cis667,eventdrivenprogramming).
class(c145,cs1).
class(c331,theoryofcomputation).
class(m112,algebra).
class(m221,calculus).
class(cis710,intotocomp).

% Just like any other language, the order of the parameters matters.
% You have to decide what the
enroll(123,cis774).
enroll(123,cis667).
enroll(123,m221).

enroll(234,cis774).
enroll(234,m112).

enroll(456,c145).
enroll(456,m112).
enroll(456,c331).
enroll(456,cis774).
enroll(456,cis667).

enroll(678,c145).
enroll(678,m221).
enroll(678,c331).
enroll(678,cis774).
enroll(678,cis667).

enroll(990,c145).

enroll(505,m112).
enroll(505,c331).

enroll(135,cis774).
enroll(135,cis710).

enroll(246,cis667).
enroll(246,cis710).

enroll(222, m112).

% Every course has a teacher.
% Some have two teachers, as there are multiple sections.
teaches(111,c145).
teaches(111,c331).
teaches(111,cis774).
teaches(222,m112).
teaches(222,m221).
teaches(222,m221).
teaches(333,cis667).
teaches(333,cis710).
teaches(333,cis774).

% check classmates using student number X and Y for a course C.
classmates(X, Y, C) :-


% check classmates using student names Xname and Yname for a course Cname.
classmates(Xname, Yname, Cname) :-


% get student classes Cname from the student name Xname.
studentName(Xname, Cname) :-


% get teacher courses Cname from teacher name Xname.
teacher(Xname, Cname) :-

% A teaching assistant is a teacher who is also enrolled in some class. We want just the name.

teachingAssistant(Xname) :-








