python
import sys
sys.path.insert(1, '/home/vandebun/Boost-Pretty-Printer')
import boost
boost.register_printers(boost_version=(1,67,0))
end
