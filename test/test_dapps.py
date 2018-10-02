import subprocess
import sys
import os
from pathlib import Path

class print_and_log(object):
    def __init__(self, filename=""):
        self.terminal = sys.stdout
        self.log = open(filename, "w")

    def write(self, message):
        self.terminal.write(message)
        self.log.write(message)

    def flush(self):
        pass

def run_test(commands, env, summary):
    args=commands.split(';')
    path=Path(args[0])
    #copy the .env file
    subprocess.run(["cp",".env",path])
    os.chdir(path)
    filename="dapp_"+args[1]+".log"
    sys.stdout= print_and_log(filename)
    #file_write=open(filename, "w")
    #run all the tests
    print ("Running "+ args[0] + " and saving results to " + filename)
    for i in range(2,len(args)):
        cmd = args[i].replace("{ENV}",env)
        if len(cmd) > 0 and cmd[0] is not '#':
            print(cmd)
            process=subprocess.run([cmd], shell=True)
            #process=subprocess.Popen(cmd, shell=True,stdout=subprocess.PIPE,bufsize=1)
            #for line in iter(process.stdout.readline, b''):
            #    sys.stdout.buffer.write(line.decode('utf-8'))
            #    file_write.write(line.decode('utf-8'))

    
    summary+=args[1]+":\n"

def main():
    if len(sys.argv) < 3 or not os.path.isfile(".env"):
        print("""Error: Prerequisites not satisfied. 
              Please confirm:
              1) tests.list file is specified and exists
              1) Environment specified
              2) .env file exists
              Example: python3 test_dapps.py tests.list thunder""")
        sys.exit(1)
    file = open(sys.argv[1])
    main_dir=os.getcwd()
    summary="Summary:\n"
    for line in file.readlines():
        if not line.strip() or line[0] is "#":
            continue
        os.chdir(main_dir)
        run_test(line, sys.argv[2],summary)
    print(summary)
    sys.exit(0)

main()
