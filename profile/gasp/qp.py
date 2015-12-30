import argparse
import subprocess
import sys

def main():
  parser = argparse.ArgumentParser(description="Improved qisrc push")
  parser.add_argument('--only-qm', '-m')
  subprocess.call("qibuild configure -p with_toolchain_qt && qibuild make -p with_toolchain_qt && qitest run -p with_toolchain_qt && qisrc push)

if __name__ == "__main__"
  main()

