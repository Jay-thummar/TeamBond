import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import { Share2, Users, Calendar, MapPin, ExternalLink, Bot } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

const MyHackathons = () => {
    const navigate = useNavigate();
    const [hackathons, setHackathons] = useState([]);
    const [loading, setLoading] = useState(true);
    const [selectedHackathon, setSelectedHackathon] = useState(null);
    const [candidates, setCandidates] = useState([]);
    const [rankingLoading, setRankingLoading] = useState(false);
    const [error, setError] = useState('');

    const userId = localStorage.getItem('userId');

    useEffect(() => {
        fetchMyHackathons();
    }, []);

    const fetchMyHackathons = async () => {
        try {
            const response = await axios.get(`http://localhost:8080/api/hackathons/my-hackathons?userId=${userId}`, {
                withCredentials: true
            });
            setHackathons(response.data);
            setLoading(false);
        } catch (err) {
            console.error("Error fetching hackathons:", err);
            setError("Failed to load your hackathons.");
            setLoading(false);
        }
    };

    const fetchCandidates = async (hackathonId) => {
        setRankingLoading(true);
        setCandidates([]);
        try {
            const response = await axios.get(`http://localhost:8080/api/hackathons/${hackathonId}/match-candidates`, {
                withCredentials: true
            });
            setCandidates(response.data);
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

    return (
        <div className="p-6 bg-gray-900 min-h-screen text-white">
            <h1 className="text-3xl font-bold mb-6 bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent">
                My Hackathons
            </h1>

            {loading ? (
                <div className="flex justify-center mt-20"><div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-500"></div></div>
            ) : error ? (
                <div className="text-red-400 text-center">{error}</div>
            ) : hackathons.length === 0 ? (
                <div className="text-gray-400 text-center mt-20">You haven't created any hackathons yet.</div>
            ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {hackathons.map((hackathon) => (
                        <motion.div
                            key={hackathon.id}
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            className="bg-gray-800 rounded-xl p-5 border border-gray-700 hover:border-blue-500 transition-all shadow-lg hover:shadow-blue-500/20"
                        >
                            <div className="flex justify-between items-start mb-4">
                                <h2 className="text-xl font-semibold truncate pr-4">{hackathon.title}</h2>
                                <span className={`px-2 py-1 rounded text-xs ${new Date(hackathon.registrationDates.end) > new Date() ? 'bg-green-500/20 text-green-400' : 'bg-red-500/20 text-red-400'}`}>
                                    {new Date(hackathon.registrationDates.end) > new Date() ? 'Active' : 'Ended'}
                                </span>
                            </div>

                            <p className="text-gray-400 text-sm mb-4 line-clamp-2">{hackathon.about}</p>

                            <div className="space-y-2 text-sm text-gray-300 mb-6">
                                <div className="flex items-center"><Calendar className="w-4 h-4 mr-2 text-blue-400" /> {new Date(hackathon.hackathonDates.start).toLocaleDateString()}</div>
                                <div className="flex items-center"><Users className="w-4 h-4 mr-2 text-purple-400" /> {hackathon.teamSize?.min}-{hackathon.teamSize?.max} Members</div>
                            </div>

                            <button
                                onClick={() => openRankingModal(hackathon)}
                                className="w-full flex items-center justify-center gap-2 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white py-2 rounded-lg font-medium transition-all"
                            >
                                <Bot className="w-5 h-5" /> AI Match Candidates
                            </button>
                        </motion.div>
                    ))}
                </div>
            )}

            {/* AI Ranking Modal */}
            <AnimatePresence>
                {selectedHackathon && (
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        className="fixed inset-0 bg-black/80 backdrop-blur-sm z-50 flex justify-center items-center p-4"
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
                                <button onClick={closeRankingModal} className="text-gray-400 hover:text-white">&times;</button>
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
        </div>
    );
};

export default MyHackathons;
