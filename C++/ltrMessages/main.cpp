#include <iostream>
#include <string>
#include <thread>

using std::cout;

int main()
{
    std::string str = "Hello David!";
    for (int i = 0; i < str.length(); i++) {
        cout << str[i] << std::flush;
        std::this_thread::sleep_for(std::chrono::milliseconds(50));
    }
    cout << "\n";
    cout << "\a";
    return 0;
}
