'''Test Thunder'''
from datetime import datetime
import argparse
import subprocess
import os
import sys

class print_and_log(object):
    def __init__(self, filename=""):
        self.terminal = sys.stdout
        self.log = open(filename, "w")

    def write(self, message):
        self.terminal.write(message)
        self.log.write(message)

    def flush(self):
        pass

def run_tests(logfile,network, identifier, filepath, timeout):
    """Run some tests"""
    command = "truffle test --network "+ network
    for file in os.listdir(filepath):
        if identifier in file:
            CMD = "truffle test "+filepath+"/"+file+ " --network "+network
            print(CMD)
            process=subprocess.Popen(CMD, shell=True,stdout=subprocess.PIPE)
            for line in iter(process.stdout.readline, b''):
                sys.stdout.write(line.decode('utf-8'))
                logfile.write(line.decode('utf-8'))

def main():
    start_time = datetime.now().time().replace(microsecond=0)
    #tests = open("openzeppelin_tests.txt","r")
    tests = open("onetest.txt","r")
    with open('dapp_openzeppelin.log','w') as logfile:
        for line in tests.readlines():
            arr=line.split(' ')
            run_tests(logfile,sys.argv[1],arr[0],arr[1],arr[2])

    PASS=0
    FAIL=0
    for line in open("dapp_openzeppelin.log"):
        if "✓" in line:
            PASS+=1
        if "Error:" in line:
            FAIL+=1
    end_time = datetime.now().time().replace(microsecond=0)
    print("START: ", start_time, ", END: ", end_time)
    print(PASS, " tests PASS")
    print(FAIL, " tests FAIL")
    exit(0)

main()
