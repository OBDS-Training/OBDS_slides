### Goals and objectives

Understanding what 'objects' are is key to understanding:

- Why some functions behave differently based on the type of objects they are given as arguments.
- Why *R* sometimes seems to behave strangely.
- Error messages.

### Procedural programming

In procedural programming, workflows are subvidided into 'tasks' solved by individual functions that call each other.

"Divide and conquer":
Functions subdivide large workflows into smaller 'tasks'.

"Reuse":
A function originally written to solve a task in one workflow can be reused to solve the same task in another workflow.

"Readable?":
When the name of functions are intuitive or self-explanatory, reading the name of functions in a workflow is more readable than reading the many lines of code inside those functions.
However, something intuitive for one person may not be obvious to another.

"Sustainable?":
Each function is much smaller than a complete workflow, and easier to maintain.
However, while most functions start by solving simple tasks, they often evolve over time with more complex behaviours, more arguments, etc.
Functions that call each other may also be affected by changes in those other functions; it can be difficult to keep track of the interactions between all the functions used in a workflow.

"Easier to debug":
Function that are short and specialised in solving a particular task can be rapidly tested in isolation (i.e., outside a long workflow).
However, functions that call each other may also be affected by changes in those other functions, and stop working due to changes in those other functions.

### Object-oriented programming

Focused on the objects that represent milestones in the workflow, rather than the functions that represent the tasks performed at each step in the workflow.

Illustration simulates two workflows whereby two objects of two different types (called, 'classes') are processed by the same functions (called 'methods').

Method-1 does something and returns as its output an object of the same class as its input.

Method-2 also does something but returns an object of class B whatever the class of its input.

Finally, the illustration hints that attempting to use the method-1 designed for class A on an object of class will frequently result in an error (or worse, a misleading result).

