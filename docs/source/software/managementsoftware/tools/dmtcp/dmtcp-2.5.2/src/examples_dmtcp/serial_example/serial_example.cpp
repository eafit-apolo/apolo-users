#include <iostream>
#include <chrono>
#include <thread>
#include <ctime>
using namespace std;

int main(){
  time_t rawtime;

  cout << "Hello world" << endl;

  for (int i = 0; i < 60; ++i) {
    this_thread::sleep_for(chrono::seconds(1));
    time(&rawtime);
    cout << "i = " << i << '\n' << ctime(&rawtime);
  }

  cout << "Goodbye world" << endl;
}
