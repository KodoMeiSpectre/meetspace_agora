using UnityEngine;
using Photon;

[RequireComponent(typeof(PhotonView))]
public class NetworkedUintManager : Photon.MonoBehaviour
{
    [SerializeField]
    private uint networkedUint = 0;

    public uint outputUint = 0;

    public AgoraVideoChat agoraVideoChat;

    [SerializeField]
    private GameObject matchingVideoPanel;

    private void Awake()
    {
        agoraVideoChat = GetComponent<AgoraVideoChat>();
    }

    public void UpdateUid(uint uid)
    {
        if (photonView.isMine && outputUint == 0)
        {
            networkedUint = uid;
            string uintString = networkedUint.ToString();
            photonView.RPC("UpdateUint", PhotonTargets.AllBuffered, uintString);
        }
    }

    [PunRPC]
    private void UpdateUint(string uintString)
    {
        uint newValue = uint.Parse(uintString);
        networkedUint = newValue;
        Debug.Log($"Updated networkedUint to {networkedUint} on {photonView.isMine}");

        HandleUintChange();
    }

    private void HandleUintChange()
    {
        Debug.Log("Searching: " + networkedUint);
        outputUint = networkedUint;
        matchingVideoPanel = GameObject.Find(outputUint.ToString());
        matchingVideoPanel.transform.SetParent(agoraVideoChat.spawnPoint);
        matchingVideoPanel.transform.rotation = Quaternion.Euler(Vector3.right * -180);
    }
}
