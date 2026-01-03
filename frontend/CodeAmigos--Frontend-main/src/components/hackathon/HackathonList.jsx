import React, { useState, useEffect } from "react";
import HackathonCard from "./HackathonCard";
import HackathonMap from "./HackathonMap";
import { useAuth } from "../../context/AuthContext";
import { Navigate, useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";

const API_BASE = import.meta.env.VITE_API_BASE_URL;

const HackathonList = ({
  setHackathons,
  filteredHackathons,
  setFilteredHackathons,
  type,
  joinable,
}) => {
  const navigate = useNavigate();
  const { username, status, userId } = useAuth();
  const [latitude, setLatitude] = useState(localStorage.getItem("latitude"));
  const [longitude, setLongitude] = useState(localStorage.getItem("longitude"));

  // AI Ranking State
  const [selectedHackathon, setSelectedHackathon] = useState(null);
  const [candidates, setCandidates] = useState([]);
  const [rankingLoading, setRankingLoading] = useState(false);

  const radius = 600
  const fetchHackathons = async () => {
    if (type === "past") {
      const response = await fetch(`${API_BASE}/api/hackathons/past`, {
        credentials: 'include',
      });

      const data = await response.json();
      console.log(response);
      setHackathons(data);
      setFilteredHackathons(data);
    }
    if (type === "ongoing") {
      const response = await fetch(
        `${API_BASE}/api/hackathons/ongoing`, {
        credentials: 'include',
      }
      );
      const data = await response.json();
      setHackathons(data);
      setFilteredHackathons(data);
    }
    if (type === "upcoming") {
      const response = await fetch(
        `${API_BASE}/api/hackathons/upcoming`, {
        credentials: 'include',
      }
      );
      const data = await response.json();
      setHackathons(data);
      setFilteredHackathons(data);
    }
    if (type == "nearby") {
      if (status !== "paid") {
        navigate("/dashboard");
      }
      else {
        const response = await fetch(
          `${API_BASE}/api/hackathons/nearby-hackathons?latitude=${latitude}&longitude=${longitude}&radius=600`, {
          credentials: 'include',
        }
        );
        const data = await response.json();
        setHackathons(data);
        setFilteredHackathons(data);
      }
    }
    if (type == "recommended") {
      if (status !== "paid") {
        navigate("/dashboard");
      }
      else {
        console.log("Hello");

        const response = await fetch(
          `${API_BASE}/api/hackathons/recommended-hackathons?username=${username}`, {
          credentials: 'include',
        }
        );
        const data = await response.json();
        console.log(data);

        if (data.length == 0) {
          setHackathons(["No recommended Hacathons found"])

        } else {
          const hackathons = data.map(item => item.hackathon)
          setHackathons(hackathons);
          setFilteredHackathons(hackathons);
        }
      }
    }
    if (type === "all") {
      const response = await fetch(`${API_BASE}/api/hackathons`, {
        credentials: 'include',
      });
      const data = await response.json();
      setHackathons(data);
      setFilteredHackathons(data);
    }
    if (type === "my-hackathons") {
      const response = await fetch(`${API_BASE}/api/hackathons/my-hackathons?userId=${userId}`, {
        credentials: 'include',
      });
      const data = await response.json();
      setHackathons(data);
      setFilteredHackathons(data);
    }
  };

  const fetchCandidates = async (hackathonId) => {
    setRankingLoading(true);
    setCandidates([]);
    try {
      const response = await fetch(`${API_BASE}/api/hackathons/${hackathonId}/match-candidates`, {
        credentials: 'include'
      });
      const data = await response.json();
      setCandidates(data);
    } catch (err) {
      console.error("Error fetching ranking:", err);
      alert("Failed to fetch AI ranking.");
    } finally {
      setRankingLoading(false);
    }
  };

  const openRankingModal = (hackathon) => {
    setSelectedHackathon(hackathon);
    fetchCandidates(hackathon.id);
  }

  const closeRankingModal = () => {
    setSelectedHackathon(null);
    setCandidates([]);
  };

  useEffect(() => {
    setFilteredHackathons([]);
    fetchHackathons();
  }, [type, latitude, longitude]);

  return (
    <>
      {
        type == "nearby" && <HackathonMap latitude={latitude} longitude={longitude} radius={radius} hackathons={filteredHackathons} />
      }
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 bg-transparent">
        {Array.isArray(filteredHackathons) &&
          filteredHackathons.map((hackathon, index) => (
            <HackathonCard key={index} {...hackathon} joinable={joinable} type={type} onMatchClick={() => openRankingModal(hackathon)} />
          ))}
      </div>

      {/* AI Ranking Modal */}
      <AnimatePresence>
        {selectedHackathon && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 bg-black/80 backdrop-blur-sm z-[60] flex justify-center items-center p-4"
          >
            <motion.div
              initial={{ scale: 0.95 }}
              animate={{ scale: 1 }}
              className="bg-gray-800 rounded-2xl w-full max-w-2xl max-h-[85vh] overflow-hidden flex flex-col shadow-2xl border border-gray-700"
            >
              <div className="p-6 border-b border-gray-700 flex justify-between items-center bg-gray-900">
                <div>
                  <h2 className="text-2xl font-bold text-white">AI Candidate Ranking</h2>
                  <p className="text-gray-400 text-sm">For: {selectedHackathon.title}</p>
                </div>
                <button onClick={closeRankingModal} className="text-gray-400 hover:text-white text-2xl">&times;</button>
              </div>

              <div className="p-6 overflow-y-auto custom-scrollbar flex-1">
                {rankingLoading ? (
                  <div className="flex flex-col items-center justify-center h-48 gap-4">
                    <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-500"></div>
                    <p className="text-purple-300 animate-pulse">Gemini is analyzing user profiles...</p>
                  </div>
                ) : candidates.length === 0 ? (
                  <div className="text-center text-gray-500 py-10">No eligible candidates found.</div>
                ) : (
                  <div className="space-y-4">
                    {candidates.map((candidate, index) => (
                      <div key={index} className="bg-gray-700/50 p-4 rounded-xl border border-gray-600 flex items-start gap-4">
                        <div className={`flex-shrink-0 w-12 h-12 rounded-full flex items-center justify-center font-bold text-lg
                                            ${index === 0 ? 'bg-yellow-500/20 text-yellow-500 border border-yellow-500/50' :
                            index === 1 ? 'bg-gray-400/20 text-gray-400 border border-gray-400/50' :
                              index === 2 ? 'bg-orange-700/20 text-orange-400 border border-orange-700/50' :
                                'bg-gray-600 text-gray-300'}`}
                        >
                          #{index + 1}
                        </div>
                        <div className="flex-1">
                          <div className="flex justify-between items-center mb-1">
                            <h3 className="font-bold text-lg text-white">{candidate.username}</h3>
                            <span className={`px-3 py-1 rounded-full text-xs font-bold 
                                                    ${candidate.match_score >= 80 ? 'bg-green-500/20 text-green-400' :
                                candidate.match_score >= 50 ? 'bg-yellow-500/20 text-yellow-400' :
                                  'bg-red-500/20 text-red-400'}`}
                            >
                              {candidate.match_score}% Match
                            </span>
                          </div>
                          <p className="text-gray-300 text-sm leading-relaxed">{candidate.reason}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
};

export default HackathonList;
