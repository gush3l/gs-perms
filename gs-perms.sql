CREATE TABLE `gs-perms` (
  `license` varchar(255) NOT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '["command.help","default.permissions"]',
  `groups` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '["user"]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `gs-perms`
  ADD UNIQUE KEY `license` (`license`);
COMMIT;