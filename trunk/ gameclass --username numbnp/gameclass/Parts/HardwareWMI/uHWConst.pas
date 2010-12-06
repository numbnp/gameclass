//////////////////////////////////////////////////////////////////////////////
//
// Модуль констант для подсистемы определения оборудования.
//
//////////////////////////////////////////////////////////////////////////////

unit uHWConst;

interface

const
  DIVIDER_FOR_HW_AS_STRING = ' ';

  HW_GROUP_TAG = 'HW_GROUP';

  CPU_GROUP_TAG = 'CPUS';
  MEMORY_GROUP_TAG = 'MEMORIES';
  SOUND_GROUP_TAG = 'SOUNDS';
  HDD_GROUP_TAG = 'HDDS';
  CDROM_GROUP_TAG = 'CDROMS';
  FLOPPY_GROUP_TAG = 'FLOPPIES';
  NETWORK_GROUP_TAG = 'NETWORKS';

  HW_PREFIX = 'HW';

  SYSTEM_TAG = 'SYSTEM';
  CPU_TAG = 'CPU';
  MEMORY_TAG = 'MEM';
  SOUND_TAG = 'SOUND';
  HDD_TAG = 'HDD';
  CDROM_TAG = 'CDROM';
  FLOPPY_TAG = 'FLOPPY';
  VIDEO_TAG = 'VIDEO';
  NETWORK_TAG = 'NET';

  TAG_SYSTEM_COMPUTER_NAME = 'ComputerName';
  TAG_SYSTEM_NUMBER_OF_PROCESSORS = 'NumberOfProcessors';
  TAG_SYSTEM_BIOS_VERSION = 'BIOSVersion';
  TAG_SYSTEM_MB_SERIAL_NUMBER = 'MBSerialNumber';

  TAG_CPU_DEVICE_ID = 'DeviceId';
  TAG_CPU_NAME = 'Name';
  TAG_CPU_PROCESSOR_ID = 'ProcessorId';
  TAG_CPU_MAX_CLOCK_SPEED = 'MaxClockSpeed';
  TAG_CPU_VERSION = 'Version';

  TAG_MEMORY_BANK_LABEL = 'BankLabel';
  TAG_MEMORY_CAPACITY = 'Capacity';
  TAG_MEMORY_NAME = 'Name';
  TAG_MEMORY_SPEED = 'Speed';

  TAG_SOUND_DEVICE_ID = 'DeviceId';
  TAG_SOUND_NAME = 'Name';

  TAG_HDD_DEVICE_ID = 'DeviceId';
  TAG_HDD_CAPTION = 'Caption';
  TAG_HDD_MODEL = 'Model';
  TAG_HDD_NAME = 'Name';
  TAG_HDD_SIZE = 'Size';
  TAG_HDD_INTERFACE_TYPE = 'InterfaceType';

  TAG_CDROM_NAME = 'Name';
  TAG_CDROM_MEDIA_TYPE = 'MediaType';

  TAG_FLOPPY_DEVICE_ID = 'DeviceId';
  TAG_FLOPPY_NAME = 'Name';

  TAG_VIDEO_RAMCAPACITY = 'RAMCapacity';
  TAG_VIDEO_NAME = 'Name';
  TAG_VIDEO_VIDEO_PROCESSOR = 'VideoProcessor';

  TAG_NET_CAPTION = 'Caption';
  TAG_NET_MAC_ADDRESS = 'MACAddress';


implementation

end.
