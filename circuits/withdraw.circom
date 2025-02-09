pragma circom 2.0.0;

template WithdrawProof() {
    signal input balance;
    signal input secret;
    signal output commitment;

    component hash = Poseidon(2);
    hash.inputs[0] <== balance;
    hash.inputs[1] <== secret;
    commitment <== hash.out;
}

component main = WithdrawProof();
