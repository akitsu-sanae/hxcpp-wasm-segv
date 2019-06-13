#include "Test.h"

extern "C" {
    extern void hxcpp_set_top_of_stack();

    void Test_run() {
        hxcpp_set_top_of_stack();
        Test_obj::run();
    }

}

