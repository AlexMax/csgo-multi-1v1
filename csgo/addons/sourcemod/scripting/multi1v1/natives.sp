// See include/multi1v1.inc for documentation.

public APLRes:AskPluginLoad2(Handle:myself, bool:late, String:error[], err_max) {
    CreateNative("Multi1v1Message", Native_Multi1v1Message);
    CreateNative("Multi1v1MessageToAll", Native_Multi1v1MessageToAll);
    CreateNative("GetMaxArenas", Native_GetMaxArenas);
    CreateNative("GetNumActiveArenas", Native_GetNumActiveArenas);
    CreateNative("IsInWaitingQueue", Native_IsInWaitingQueue);
    CreateNative("GetWaitingQueue", Native_GetWaitingQueue);
    CreateNative("HasStats", Native_HasStats);
    CreateNative("GetRating", Native_GetRating);
    CreateNative("GetArenaNumber", Native_GetArenaNumber);
    CreateNative("GetRoundsAtArena1", Native_GetRoundsAtArena1);
    CreateNative("GetOpponent", Native_GetOpponent);
    RegPluginLibrary("multi1v1");
    return APLRes_Success;
}

public Native_Multi1v1Message(Handle:plugin, numParams) {
    new client = GetNativeCell(1);
    if (!IsPlayer(client))
        return;

    decl String:buffer[1024];
    new writtenBytes;
    FormatNativeString(0, 2, 3, sizeof(buffer), writtenBytes, buffer);
    PrintToChat(client, "%s%s", MESSAGE_PREFIX, buffer);
}

public Native_Multi1v1MessageToAll(Handle:plugin, numParams) {
    decl String:buffer[1024];
    new writtenBytes;
    FormatNativeString(0, 1, 2, sizeof(buffer), writtenBytes, buffer);
    PrintToChatAll("%s%s", MESSAGE_PREFIX, buffer);
}

public Native_GetMaxArenas(Handle:plugin, numParams) {
    return g_maxArenas;
}

public Native_GetNumActiveArenas(Handle:plugin, numParams) {
    return g_arenas;
}

public Native_IsInWaitingQueue(Handle:plugin, numParams) {
    new client = GetNativeCell(1);
    return Queue_Inside(g_waitingQueue, client);
}


public Native_GetWaitingQueue(Handle:plugin, numParams) {
    return _:g_waitingQueue;
}

public Native_HasStats(Handle:plugin, numParams) {
    new client = GetNativeCell(1);
    return IsPlayer(client) && g_FetchedPlayerInfo[client];
}

public Native_GetRating(Handle:plugin, numParams) {
    new client = GetNativeCell(1);
    if (!IsValidClient(client))
        return _:0.0;
    else
        return _:g_Rating[client];
}

public Native_GetArenaNumber(Handle:plugin, numParams) {
    new client = GetNativeCell(1);
    if (!IsValidClient(client))
        return -1;
    else
        return g_Ranking[client];
}

public Native_GetRoundsAtArena1(Handle:plugin, numParams) {
    new client =  GetNativeCell(1);
    if (!IsValidClient(client))
        return 0;
    else
        return g_RoundsLeader[client];
}

public Native_GetOpponent(Handle:plugin, numParams) {
    new client = GetNativeCell(1);
    if (IsValidClient(client))
        return GetOpponent(client);
    return -1;
}