import snoop
import sys

sys.breakpointhook = snoop.snoop
snoop.install()
