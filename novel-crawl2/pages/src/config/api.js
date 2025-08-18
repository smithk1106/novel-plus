// API 基础配置
//const baselUrl = window.location.protocol === 'https:' ? 'https://novel.x.com/api' : 'http://127.0.0.1:30000/api';
const baselUrl = 'localhost,127.0.0.1'.indexOf(window.location.hostname) >= 0
    ? `${window.location.protocol}//${window.location.hostname}:8584/api`
    : `${window.location.protocol}//${window.location.host}/api`;
export const API_BASE_URL = `${baselUrl}`;

// WebSocket 配置
//const websocketUrl = window.location.protocol === 'https:' ? 'wss://novel.x.com/ws' : 'ws://127.0.0.1:30000/ws';
const websocketUrl = 'localhost,127.0.0.1'.indexOf(window.location.hostname) >= 0
    ? `ws://${window.location.hostname}:8584/ws`
    : `wss://${window.location.host}/ws`;

// console.log('websocketUrl:', websocketUrl);
export const WS_URL = `${websocketUrl}`;

// API 路径配置
export const API_URLS = {
  // 小说相关
  NOVEL: {
    LIST: '/novel/list',
    DELETE: (id) => `/novel/delete/${id}`,
    DOWNLOAD: (id) => `/download/${id}`,
  },
  // 配置相关
  CONFIG: {
    GET: '/config/getConfig',
    GET_SOURCE_INFO: '/config/getSourceInfo',
    UPDATE: '/config/updateConfig',
  }
}

// 创建完整的 API URL
export const getFullUrl = (path) => `${API_BASE_URL}${path}` 