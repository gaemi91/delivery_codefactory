import 'dart:io';

const ipEmulator = '10.0.2.2:3000';
const ipSimulator = '127.0.0.1:3000';
final ip = Platform.isMacOS ? ipSimulator : ipEmulator;

const Token_Key_Access = 'accessToken';
const Token_Key_Refresh = 'refreshToken';
const authorization = 'authorization';
