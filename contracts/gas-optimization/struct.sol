/* SETTING STRUCT VALUES */

// CHEAP
contract SetStructs_1 {
     struct Test{
         uint256 a;
         uint256 b;
         bytes32 c;
         bytes32 d;
     }
     
     function InMemoryUsage() public {
         (int256 a, int256 b, bytes32 c, bytes32 d) = (1,2, "a","b");
     }
}

// COSTLY
contract SetStructs_2 {
    Test test;
    
     struct Test{
         uint256 a;
         uint256 b;
         bytes32 c;
         bytes32 d;
     }
     
     function InMemoryUsage() public {
         test = Test(1,2, "a","b");
     }
}

/* PASSING STRUCT TO FUNCTIONS */

// CHEAP
contract PassStruct_1 {
     struct Test{
         uint256 a;
         uint256 b;
         bytes32 c;
         bytes32 d;
     }
     
     function InMemoryUsage() public {
         Test memory test;
         test.a = 1;
         test.b = 2;
         test.c = "a";
         test.d = "b";
         
         passData(test);
     }
     
     function passData(Test memory t) private {
         
     }
}

// COSTLY
contract PassStruct_2 {
     struct Test{
         uint256 a;
         uint256 b;
         bytes32 c;
         bytes32 d;
     }
     
     function InMemoryUsage() public {
         Test memory test;
         test.a = 1;
         test.b = 2;
         test.c = "a";
         test.d = "b";
         
         passData(1,2,"a","b");
     }
     
     function passData(uint256 a, int256 b, bytes32 c, bytes32 d) private {
         
     }
}