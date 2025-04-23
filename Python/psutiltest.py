# GPU information
import GPUtil
import psutil
# GPU----------------------------
from tabulate import tabulate
for p in psutil.disk_partitions(all=True):
    print(f"Device: {p.device}, Mountpoint: {p.mountpoint}, Fstype: {p.fstype}, Opts: {p.opts}")