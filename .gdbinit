python
import sys
sys.path.insert(1, '/home/vandebun/Boost-Pretty-Printer')
import boost
boost.register_printers(boost_version=(1,67,0))
end
python
import sys
sys.path.insert(0, '/home/vandebun/eigen_printers')
from printers import register_eigen_printers
register_eigen_printers (None)
end
