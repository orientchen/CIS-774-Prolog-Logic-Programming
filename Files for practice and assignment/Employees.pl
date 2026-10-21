person(123,john).
person(234,andrew).
person(456,megan).
person(678,jeremy).
person(990,thor).


employee(123).
employee(234).
employee(456).


manager(678).
manager(990).

department(1,accounting).
department(2,sales).

worksAt(123, 1).
worksAt(123, 2).
worksAt(234, 1).
worksAt(456, 2).
worksAt(678, 1).
worksAt(990, 2).


salary(123,3000).
salary(234,2000).
salary(456,2000).
salary(678,5000).
salary(990,6000).


% get the salary S of person P using person's name
getSalary(P, S) :- 

% get every one who works at department D (using department name)
getEveryBody(D) :- 

% get the manager M of department D using department name
getManager(D, M) :- 

% get all employees E who works at department D using department name
getEmployees(D, E) :- 

% get all the department wherer employee E works using employee name
worksAtDepartments(E) :- 
