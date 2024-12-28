USE iotdb;

-- Insert Users
INSERT INTO `Users` (`userName`, `passwordHash`) VALUES
('admin', 'hash_admin123'), 
('user1', 'hash_user123');

-- Insert Equipment_Plug
INSERT INTO `Equipment_Plug` (`equipmentID`, `equipmentName`, `numberSocket`, `position`, `manager`) VALUES
(UUID(), 'SmartPlug_A', 4, 'Room 101', 'admin'),
(UUID(), 'SmartPlug_B', 2, 'Room 102', 'user1');

-- Insert Script
INSERT INTO `Script` (`scriptName`, `status`) VALUES
('MorningRoutine', 1),
('NightRoutine', 0);

-- Insert Socket
INSERT INTO `Socket` (`socketID`, `socketName`, `equipmentID`, `status`, `scriptName`) VALUES
(UUID(), 'Socket_1', (SELECT equipmentID FROM Equipment_Plug WHERE equipmentName = 'SmartPlug_A'), 1, 'MorningRoutine'),
(UUID(), 'Socket_2', (SELECT equipmentID FROM Equipment_Plug WHERE equipmentName = 'SmartPlug_A'), 0, 'MorningRoutine'),
(UUID(), 'Socket_3', (SELECT equipmentID FROM Equipment_Plug WHERE equipmentName = 'SmartPlug_A'), 0, NULL),
(UUID(), 'Socket_4', (SELECT equipmentID FROM Equipment_Plug WHERE equipmentName = 'SmartPlug_A'), 0, NULL),
(UUID(), 'Socket_1', (SELECT equipmentID FROM Equipment_Plug WHERE equipmentName = 'SmartPlug_B'), 1, 'NightRoutine'),
(UUID(), 'Socket_2', (SELECT equipmentID FROM Equipment_Plug WHERE equipmentName = 'SmartPlug_B'), 0, NULL);

-- Insert DS_Temperature
INSERT INTO `DS_Temperature` (`sequenceID`, `date`, `dsID`, `temperature`, `equipmentID`) VALUES
(UUID(), '2024-12-28 08:00:00', 'DS_001', '22.5', (SELECT equipmentID FROM Equipment_Plug WHERE equipmentName = 'SmartPlug_A')),
(UUID(), '2024-12-28 09:00:00', 'DS_001', '23.0', (SELECT equipmentID FROM Equipment_Plug WHERE equipmentName = 'SmartPlug_A'));

-- Insert ACS_Current
INSERT INTO `ACS_Current` (`seqID`, `date`, `acsID`, `current`, `equipmentID`) VALUES
(UUID(), '2024-12-28 08:00:00', 'ACS_001', '2.5A', (SELECT equipmentID FROM Equipment_Plug WHERE equipmentName = 'SmartPlug_B')),
(UUID(), '2024-12-28 09:00:00', 'ACS_001', '3.0A', (SELECT equipmentID FROM Equipment_Plug WHERE equipmentName = 'SmartPlug_B'));
