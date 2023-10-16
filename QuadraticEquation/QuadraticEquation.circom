pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";

// Create a Quadratic Equation( ax^2 + bx + c ) verifier using the below data.
// Use comparators.circom lib to compare results if equa

template Multiply() {
    signal input in[2];
    signal output out;

    // signal temp;
    // temp <-- in[0] * in[1];

    out <== in[0] * in[1];
}

template Power2() {
    signal input in[2];
    
    signal temp;
    
    signal output out;

    temp <-- in[0] ** in[1];

    out <== temp;
}

template QuadraticEquation() {
    signal input x;     // x value
    signal input a;     // coeffecient of x^2
    signal input b;     // coeffecient of x 
    signal input c;     // constant c in equation
    signal input res;   // Expected result of the equation
    signal output out;  // If res is correct , then return 1 , else 0 . 

    signal temp;

    component p = Power2();
    p.in[0] <== x;
    p.in[1] <== 2;

    component m1 = Multiply();
    m1.in[0] <== a;
    m1.in[1] <== p.out;

    component m2 = Multiply();
    m2.in[0] <== b;
    m2.in[1] <== x;

    temp <-- m1.out + m2.out + c;

    component equal = IsEqual();
    equal.in[1] <== res;
    equal.in[0] <== temp;

    out <== equal.out;
}

component main  = QuadraticEquation();