//
//  TabViews.swift
//  Netflix
//
//  Created by Sameer Nikhil on 04/06/25.
//

import SwiftUI
import Foundation
import WebKit // for video play back we use web kit

// MARK: - Data Models

// Represents a content item in the New & Hot section
struct NewHotItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageURL: String
    let releaseDate: String
    let type: ContentType
    let genre: String
    let isRemindMeSet: Bool
    let tmdbId: Int? // TMDB ID for fetching real trailers
    let fallbackVideoKey: String? // YouTube video ID as fallback
    // Defines the type of content (movie, series, or documentary)
    enum ContentType {
        case movie, series, documentary
    }
}

// MARK: - Top 10

struct Top10Item: Identifiable {
    let id = UUID()
    let rank: Int
    let title: String
    let description: String
    let imageURL: String
    let type: ContentType
    let genre: String
    let tmdbId: Int?
    let fallbackVideoKey: String?
    
    enum ContentType {
        case movie, series, documentary
    }
}


// MARK: - New Hot Content Service
// Service class to manage New & Hot content data
class NewHotContentService: ObservableObject {
    
    @Published var comingSoonContent: [NewHotItem] = []
    @Published var everyoneWatchingContent: [NewHotItem] = []
    @Published var top10TVShows: [Top10Item] = []
    @Published var top10Movies: [Top10Item] = []
   
    
    // Loads sample content for both Coming Soon and Everyone's Watching sections
    func loadContent() {
        // Coming Soon Content - Shows upcoming releases with poster paths
        comingSoonContent = [
            NewHotItem(
                title: "Squid Game",
                description: "Final Season Coming June 27\n\nNew games. Old foes. Player 456 and the Front Man clash in a final showdown of moral dilemmas and pulse-racing challenges. Who will emerge victorious?",
                imageURL: "https://image.tmdb.org/t/p/original/2meX1nMdScFOoV4370rqHWKmXhY.jpg",
                releaseDate: "June 27",
                type: .series,
                genre: "Korean Series",
                isRemindMeSet: false,
                tmdbId: 87108, // Squid Game TMDB ID
                fallbackVideoKey: "kAtfaaUgDRU"
            ),
            NewHotItem(
                title: "Avengers: Doomday",
                description: "The Avengers, Wakandans, Fantastic Four, Thunderbolts, and X-Men all fight against Doctor Doom. Plot TBA.",
                imageURL: "https://image.tmdb.org/t/p/original/s4EPSbpbnf20oWq64lKRn28Yx7J.jpg",
                releaseDate: "July 15",
                type: .movie,
                genre: "Action Movie",
                isRemindMeSet: false,
                tmdbId: 663712, // The Old Guard 2 TMDB ID
                fallbackVideoKey: "zgGTVaG2UiQ" // ← Add YouTube video ID here

            ),
            NewHotItem(
                title: "Stranger Things 5",
                description: "Final Season Coming 2025\n\nThe final chapter in the Stranger Things saga brings our heroes together for one last battle against the Upside Down.",
                imageURL: "https://image.tmdb.org/t/p/original/fE9yVO4n987odEKhv9w5HToTjhN.jpg",
                releaseDate: "2025",
                type: .series,
                genre: "Sci-Fi Series",
                isRemindMeSet: false,
                tmdbId: 66732, // Stranger Things TMDB ID
                fallbackVideoKey: "kAtfaaUgDRU"
            ),
            NewHotItem(
                title: "The Boys: Season 5",
                description: " Butcher, with only months to live, has lost Becca's son, and his job as The Boys' leader. The rest of the team are fed up with his lies. With the stakes higher than ever, they must find a way to work together and save the world before it's too late.",
                imageURL: "https://image.tmdb.org/t/p/original/1mhrmTQnbnKivp0hZXsMMQwJbgG.jpg",
                releaseDate: "2025",
                type: .series,
                genre: "Crime Series",
                isRemindMeSet: false,
                tmdbId: 79008, // The Rookie TMDB ID
                fallbackVideoKey: "kAtfaaUgDRU"
            ),
            NewHotItem(
                title: "Avatar: Fire and Ash",
                description: "In the wake of the devastating war against the RDA and the loss of their eldest son, Jake Sully and Neytiri face a new threat on Pandora: the Ash People, a violent and power-hungry Na'vi tribe led by the ruthless Varang.",
                imageURL: "https://image.tmdb.org/t/p/original/tibsMjg99lAICuqREFvRxKVWkqg.jpg",
                releaseDate: "2025",
                type: .series,
                genre: "Action Series",
                isRemindMeSet: false,
                tmdbId: nil, // No TMDB ID available
                fallbackVideoKey: "kAtfaaUgDRU"
            ),
            NewHotItem(
                title: "Avengers: Secret Wars",
                description: "An upcoming film in Phase 6 of the Marvel Cinematic Universe (MCU) and the finale of The Multiverse Saga. Plot TBA.",
                imageURL: "https://image.tmdb.org/t/p/w1066_and_h600_bestv2/h0rLRgh21cQS2Mrou9fEcZQuaku.jpg",
                releaseDate: "2025",
                type: .series,
                genre: "Drama Series",
                isRemindMeSet: false,
                tmdbId: 119051, // Rana Naidu TMDB ID
                fallbackVideoKey: "kAtfaaUgDRU"
            ),
            NewHotItem(
                title: "Spider-Man: Beyond the Spider-Verse",
                description: "Miles Morales is now a fugitive on the run from every other Spider in the multiverse, and Gwen and his other friends might not be enough to help him.",
                imageURL: "https://image.tmdb.org/t/p/original/smp0JlTfUt0Esr7eKyroSeC8Ur6.jpg",
                releaseDate: "2025",
                type: .series,
                genre: "Sci-Fi Series",
                isRemindMeSet: false,
                tmdbId: 130392, // La Brea TMDB ID
                fallbackVideoKey: "kAtfaaUgDRU"
            ),
            NewHotItem(
                title: "Now You See Me: Now You Don't",
                description: "The Four Horsemen return along with a new generation of illusionists performing mind-melding twists, turns, surprises, and magic unlike anything ever captured on film.Unlock the illusion.",
                imageURL: "https://image.tmdb.org/t/p/original/ufqytAlziHq5pljKByGJ8IKhtEZ.jpg",
                releaseDate: "2025",
                type: .documentary,
                genre: "Documentary Series",
                isRemindMeSet: false,
                tmdbId: nil, // No TMDB ID available
                fallbackVideoKey: "kAtfaaUgDRU"
            ),
            NewHotItem(
                title: "The Batman 2",
                description: "In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.",
                imageURL: "https://image.tmdb.org/t/p/original/fLyrxFt5oaPFGemZqoL3qQ8aTs7.jpg",
                releaseDate: "2025",
                type: .series,
                genre: "Fantasy Series",
                isRemindMeSet: false,
                tmdbId: 90802, // The Sandman TMDB ID
                fallbackVideoKey: "kAtfaaUgDRU"
            ),
            NewHotItem(
                title: "F1: The Movie",
                description: "Racing legend Sonny Hayes is coaxed out of retirement to lead a struggling Formula 1 team—and mentor a young hotshot driver—while chasing one more chance at glory.",
                imageURL: "https://image.tmdb.org/t/p/original/kQOaW4f1CPLd9TS2TA60LjOPLbh.jpg",
                releaseDate: "2025",
                type: .documentary,
                genre: "Documentary",
                isRemindMeSet: false,
                tmdbId: nil, // No TMDB ID available
                fallbackVideoKey: "kAtfaaUgDRU"
            )
        ]
        
        // Everyone's Watching Content - Popular current content
        everyoneWatchingContent = [
            NewHotItem(
                title: "YOU",
                description: "Joe Goldberg returns to New York City, where his journey began, seeking a 'happily ever after' with his new wife, Kate, a billionaire CEO. However, their perfect life is threatened by Joe's past and his own dark desires.",
                imageURL: "https://image.tmdb.org/t/p/original/lTySSn1rE10KzYEC9UqJGdos5Vp.jpg",
                releaseDate: "Now Streaming",
                type: .series,
                genre: "Thriller Series",
                isRemindMeSet: false,
                tmdbId: 78191, // YOU TMDB ID
                fallbackVideoKey: "kQdEHQLHDAI" // YOU Season 4 Official Trailer
            ),
            NewHotItem(
                title: "Money Heist: Korea",
                description: "A Korean adaptation of the hit Spanish series. Thieves overtake the mint of a unified Korea in this suspenseful heist thriller.",
                imageURL: "https://image.tmdb.org/t/p/w1066_and_h600_bestv2/7kzMdMTGJWIIw9CHh4gqqZmD4uI.jpg",
                releaseDate: "Now Streaming",
                type: .series,
                genre: "Crime Series",
                isRemindMeSet: false,
                tmdbId: nil, // Money Heist: Korea TMDB ID
                fallbackVideoKey: "Uafg97czxeQ"
            ),
            NewHotItem(
                title: "SUITS",
                description: "As the firm chafes under intense new oversight, each partner faces a reckoning -- and Mike Ross returns to square off against his old mentor, Harvey.",
                imageURL: "https://image.tmdb.org/t/p/original/csP4VXPeWDuz0Mjrb7aPVKO5b71.jpg",
                releaseDate: "Now Streaming",
                type: .series,
                genre: "Legal Drama",
                isRemindMeSet: false,
                tmdbId: 37680, // Suits TMDB ID
                fallbackVideoKey: "kAtfaaUgDRU"
            ),
            NewHotItem(
                title: "BREAKING BAD",
                description: "Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live.",
                imageURL: "https://image.tmdb.org/t/p/original/yXSzo0VU1Q1QaB7Xg5Hqe4tXXA3.jpg",
                releaseDate: "Now Streaming",
                type: .series,
                genre: "Crime Drama",
                isRemindMeSet: false,
                tmdbId: 1396, // Breaking Bad TMDB ID
                fallbackVideoKey: "VFkjBy2b50Q"
            ),
            NewHotItem(
                title: "ALL OF US ARE DEAD",
                description: "It's official: another season is coming. \nA high school becomes ground zero for a zombie virus outbreak. Trapped students must fight their way out — or turn into one of the rabid infected.",
                imageURL: "https://image.tmdb.org/t/p/original/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
                releaseDate: "Now Streaming",
                type: .series,
                genre: "Horror Series",
                isRemindMeSet: false,
                tmdbId: 105084, // All of Us Are Dead TMDB ID
                fallbackVideoKey: "017_tQvH3_w"
            ),
            NewHotItem(
                title: "ALICE IN BORDERLAND",
                description: "Season 3 Coming September 2025\nThe games are deadlier, this world more wild and cruel; but will Arisu ever make it back to the real world — and will it be worth everything he's lost?",
                imageURL: "https://image.tmdb.org/t/p/original/jEeA6T6QzIAzsccq5xdi9r9fxiH.jpg",
                releaseDate: "Now Streaming",
                type: .series,
                genre: "Thriller Series",
                isRemindMeSet: false,
                tmdbId: nil, // Alice in Borderland TMDB ID
                fallbackVideoKey: "49_44FFKZ1M"
            ),
            NewHotItem(
                title: "The Gray Man",
                description: "When a shadowy CIA agent uncovers damning agency secrets, he's hunted across the globe by a sociopathic rogue operative who's put a bounty on his head.",
                imageURL: "https://image.tmdb.org/t/p/original/27Mj3rFYP3xqFy7lnz17vEd8Ms.jpg",
                releaseDate: "Now Streaming",
                type: .movie,
                genre: "Action Movie",
                isRemindMeSet: false,
                tmdbId: nil, // The Gray Man TMDB ID
                fallbackVideoKey: "BmllggGO4pM"
            ),
            NewHotItem(
                title: "DEVARA",
                description: "Devara, a fearless man from a coastal region, embarks on a perilous journey into the treacherous world of the sea to safeguard the lives of his people.",
                imageURL: "https://image.tmdb.org/t/p/original/kH3Mb0I4XFXvnRRtOsVIWE3uemo.jpg",
                releaseDate: "Now Streaming",
                type: .movie,
                genre: "Action Movie",
                isRemindMeSet: false,
                tmdbId: nil, // Devara TMDB ID
                fallbackVideoKey: "nB2ldeVAX9U"
            ),
            NewHotItem(
                title: "Kaithi",
                description: "Dilli, a convicted criminal, is out on parole to meet his daughter. However, a drug bust sets him off on a mission to save the life of police officers.",
                imageURL: "https://image.tmdb.org/t/p/original/qJIWbfTeIp2nadeghvxoJ2sQjwI.jpg",
                releaseDate: "Now Streaming",
                type: .movie,
                genre: "Action Movie",
                isRemindMeSet: false,
                tmdbId: nil, // Kaithi TMDB ID
                fallbackVideoKey: "Xv7PmlhYtEk"
            ),
            NewHotItem(
                title: "HIT: The 2nd Case",
                description: "Krishna Dev aka KD, a laidback cop working in Andhra Pradesh State HIT, takes on a gruesome murder case. As KD unravels the layers of the crime.",
                imageURL: "https://image.tmdb.org/t/p/original/huemSnJxysu4vrI8LE9iEfdalhy.jpg",
                releaseDate: "Now Streaming",
                type: .movie,
                genre: "Thriller Movie",
                isRemindMeSet: false,
                tmdbId: nil, // HIT: The 2nd Case TMDB ID
                fallbackVideoKey: "4GzAwnjVTqc"
            )
        ]
        
        // Top 10 TV Shows
        top10TVShows = [
            Top10Item(
                rank: 1,
                title: "Dexter: New Blood",
                description: "10 years after Dexter went missing in the eye of Hurricane Laura, we find him living under an assumed name in the small town of Iron Lake, New York. Dexter may be embracing his new life, but in the wake of unexpected events in this close-knit community, his Dark Passenger beckons. He's alive & killing it.",
                imageURL: "https://image.tmdb.org/t/p/w1066_and_h600_bestv2/aaIexKCa1md9boQ5gmdenj53aes.jpg",
                type: .series,
                genre: "Drama Series",
                tmdbId: nil,
                fallbackVideoKey: "t779a6O_Me0"
            ),
            Top10Item(
                rank: 2,
                title: "Lucifer",
                description: "Bored and unhappy as the Lord of Hell, Lucifer Morningstar abandoned his throne and retired to Los Angeles, where he has teamed up with LAPD detective Chloe Decker to take down criminals. But the longer he's away from the underworld, the greater the threat that the worst of humanity could escape.It's good to be bad.",
                imageURL: "https://image.tmdb.org/t/p/original/sGM9Rg74SjJEsOUVUWbS2sXU1IP.jpg",
                type: .series,
                genre: "Sci-Fi Series",
                tmdbId: nil,
                fallbackVideoKey: "ueMwVGBwqRo"
            ),
            Top10Item(
                rank: 3,
                title: "Money Heist",
                description: "To carry out the biggest heist in history, a mysterious man called The Professor recruits a band of eight robbers who have a single characteristic: none of them has anything to lose. culminate in eleven days locked up in the National Coinage and Stamp Factory of Spain, surrounded by police forces and with dozens of hostages in their power, The perfect robbery.",
                imageURL: "https://image.tmdb.org/t/p/original/uneEmfKFbyOZsN77JAHXK1cIAmX.jpg",
                type: .series,
                genre: "Sci-Fi Series",
                tmdbId: nil,
                fallbackVideoKey: "_InqQJRqGW4"
            ),
            Top10Item(
                rank: 4,
                title: "The Walking Dead: Dead City",
                description: "Maggie and Negan travel to post-apocalyptic Manhattan - long ago cut off from the mainland. The crumbling city is filled with the dead and denizens who have made it a world full of anarchy, danger, beauty, and terror.Keep your enemies close.",
                imageURL: "https://image.tmdb.org/t/p/original/vV5LKWmuysEe5wsuZJGbdiL5XJ2.jpg",
                type: .series,
                genre: "Sci-Fi Series",
                tmdbId: nil,
                fallbackVideoKey: "mrY5o-tpVuk"
            ),
            Top10Item(
                rank: 5,
                title: "Peaky Blinders",
                description: "A gangster family epic set in 1919 Birmingham, England and centered on a gang who sew razor blades in the peaks of their caps, and their fierce boss Tommy Shelby, who means to move up in the world.London's for the taking.",
                imageURL: "https://image.tmdb.org/t/p/original/n8efGaafd9xFGuTfQfQe4QjTGEn.jpg",
                type: .series,
                genre: "Sci-Fi Series",
                tmdbId: nil,
                fallbackVideoKey: "Ruyl8_PT_y8"
            ),
            Top10Item(
                rank: 6,
                title: "The Boys",
                description: "A group of vigilantes known informally as “The Boys” set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.Never meet your heroes.",
                imageURL: "https://image.tmdb.org/t/p/original/aNrcxmzCZc1Tgze4jOwJrwk7tCl.jpg",
                type: .series,
                genre: "Sci-Fi Series",
                tmdbId: nil,
                fallbackVideoKey: "EzFXDvC-EwM"
            ),
            Top10Item(
                rank: 7,
                title: "RANA NAIDU",
                description: "Rana Naidu can solve any problem in Bollywood. But when his father is suddenly released from prison, the one mess he can’t handle may be his own.",
                imageURL: "https://image.tmdb.org/t/p/original/n5zqFfQi5KjJx5c3PBxoCxy6TXl.jpg",
                type: .series,
                genre: "Sci-Fi Series",
                tmdbId: nil,
                fallbackVideoKey: "pVYg7DSCWAg"
            ),
            Top10Item(
                rank: 8,
                title: "Guns & Gulaabs",
                description: "In the cartel-run town of Gulaabgunj, an unprecedented opium deal pulls a big-city cop and a lovesick mechanic into its chaotic clutches.",
                imageURL: "https://image.tmdb.org/t/p/original/sBklEgEPbtTwWKYZZ7thUp7WAxX.jpg",
                type: .series,
                genre: "Sci-Fi Series",
                tmdbId: nil,
                fallbackVideoKey: "0dIIChsjKBc"
            ),
            Top10Item(
                rank: 9,
                title: "Dhootha",
                description: "Journalist Sagar's life turns thrilling as he unravels dark secrets behind newspaper clippings predicting tragedies. He becomes a murder suspect, racing against time to clear his name and solve the enigma and faces dangerous twists. Suspense builds in this roller-coaster ride.",
                imageURL: "https://image.tmdb.org/t/p/original/qB7yhnWBQ2oiaG2PZ3N3zFFm5L3.jpg",
                type: .series,
                genre: "Sci-Fi Series",
                tmdbId: nil,
                fallbackVideoKey: "-ITBFd_K5_M"
            ),
            Top10Item(
                rank: 10,
                title: "WEDNESDAY",
                description: "A Torturous New Season: Aug 6\n\nWednesday Addams is sent to Nevermore Academy, a bizarre boarding school where she attempts to master her psychic powers, stop a monstrous killing spree of the town citizens, and solve the supernatural mystery that affected her family 25 years ago — all while navigating her new relationships.",
                imageURL: "https://image.tmdb.org/t/p/original/ndUVIUfmtJ3vqGGTNQ0me6xbOMG.jpg",
                type: .series,
                genre: "Sci-Fi Series",
                tmdbId: nil,
                fallbackVideoKey: "uQx8jKiIDTI"
            )
        ]
        
        // Top 10 Movies - Popular current content
        top10Movies = [
            Top10Item(
                    rank: 1,
                    title: "HIT: The THIRD CASE",
                    description: "Watch in Telugu, Tamil, Malayalam, Kannada, Hindi\n\nThe Homicide Intervention Team (HIT) sends ruthless police officer Arjun Sarkaar to find a group of killers and stop their grisly murder spree.",
                    imageURL: "https://image.tmdb.org/t/p/original/lRPq7QMrrNvSTKMWyAwMupuWAfr.jpg",
                    type: .movie,
                    genre: "Thriller Movie",
                    tmdbId: nil,
                    fallbackVideoKey: "kAtfaaUgDRU"
                ),
            Top10Item(
                    rank: 2,
                    title: "Mathu Vadalara 2",
                    description: "Babu and Yesu, former delivery agents, embark on a thrilling mission as special agents, facing extraordinary challenges with humor, surprises, and nonstop excitement.",
                    imageURL: "https://image.tmdb.org/t/p/w1066_and_h600_bestv2/ofhdnkmuhMPaeee6OI8eCqjniIE.jpg",
                    type: .movie,
                    genre: "Thriller Movie",
                    tmdbId: nil,
                    fallbackVideoKey: "ahZX-ewuZP8"
                ),
            Top10Item(
                    rank: 3,
                    title: "Mission: Impossible - The Final Reckoning",
                    description: "Ethan Hunt and team continue their search for the terrifying AI known as the Entity — which has infiltrated intelligence networks all over the globe — with the world's governments and a mysterious ghost from Hunt's past on their trail.",
                    imageURL: "https://image.tmdb.org/t/p/original/x63sAJHtywkKSRf9EawD64r5122.jpg",
                    type: .movie,
                    genre: "Thriller Movie",
                    tmdbId: nil,
                    fallbackVideoKey: "fsQgc9pCyDU"
                ),
            Top10Item(
                    rank: 4,
                    title: "Dragon",
                    description: "After a top student faces rejection and heartbreak, he cons his way into a finance career. But keeping up the facade proves tricky as the lies build.",
                    imageURL: "https://image.tmdb.org/t/p/original/a8JGDgNSXYcswIemNUx2l4CudN6.jpg",
                    type: .movie,
                    genre: "Thriller Movie",
                    tmdbId: nil,
                    fallbackVideoKey: "m1i-sYxTX8I"
                ),
            Top10Item(
                    rank: 5,
                    title: "Red Notice",
                    description: "An Interpol-issued Red Notice is a global alert to hunt and capture the world's most wanted. But when a daring heist brings together the FBI's top profiler and two rival criminals, there's no telling what will happen.",
                    imageURL: "https://image.tmdb.org/t/p/original/5uVhMGsps81CN0S4U9NF0Z4tytG.jpg",
                    type: .movie,
                    genre: "Thriller Movie",
                    tmdbId: nil,
                    fallbackVideoKey: "kAtfaaUgDRU"
                ),
            Top10Item(
                    rank: 6,
                    title: "The Penguins of Madagascar",
                    description: "The Penguins of Madagascar is an American CGI animated television series airing on Nickelodeon. It stars nine characters from the DreamWorks Animation animated film Madagascar.",
                    imageURL: "https://image.tmdb.org/t/p/original/tdDRR3qnwwicr2DJbaaF8CDW168.jpg",
                    type: .movie,
                    genre: "Thriller Movie",
                    tmdbId: nil,
                    fallbackVideoKey: "KHGHEpUeUwo"
                ),
            Top10Item(
                    rank: 7,
                    title: "Spider - Man: No Way Home",
                    description: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
                    imageURL: "https://image.tmdb.org/t/p/original/68GfuBjPr1wLLctLIqxgXl2N0GJ.jpg",
                    type: .movie,
                    genre: "Thriller Movie",
                    tmdbId: nil,
                    fallbackVideoKey: "rt-2cxAiPJk"
                ),
            Top10Item(
                    rank: 8,
                    title: "Demonte Colony 2",
                    description: "Debbie attempts to contact the spirit of her deceased husband Sam, she inadvertently contacts Srinivasan, who had just died. This contact saves his life but leaves him in a coma for years. Later, Debbie unravels mystery about Lord Demonte sacrificing people and enslaves their spirits. Can Debbie break this cycle and help Srinivasan to wake up from his coma?",
                    imageURL: "https://image.tmdb.org/t/p/original/5HiqDaw4K90kplRuej1xUiSgVv7.jpg",
                    type: .movie,
                    genre: "Thriller Movie",
                    tmdbId: nil,
                    fallbackVideoKey: "KnaIq7VQpGk"
                ),
            Top10Item(
                    rank: 9,
                    title: "Venom: The Last Dance",
                    description: "Eddie and Venom are on the run. Hunted by both of their worlds and with the net closing in, the duo are forced into a devastating decision that will bring the curtains down on Venom and Eddie's last dance.",
                    imageURL: "https://image.tmdb.org/t/p/original/3V4kLQg0kSqPLctI5ziYWabAZYF.jpg",
                    type: .movie,
                    genre: "Thriller Movie",
                    tmdbId: nil,
                    fallbackVideoKey: "__2bjWbetsA"
                ),
            Top10Item(
                    rank: 10,
                    title: "Extraction 2",
                    description: "Back from the brink of death, highly skilled commando Tyler Rake takes on another dangerous mission: saving the imprisoned family of a ruthless gangster.",
                    imageURL: "https://image.tmdb.org/t/p/original/nKDoICGPqC5bN6lfK6PGFp4Echs.jpg",
                    type: .movie,
                    genre: "Thriller Movie",
                    tmdbId: nil,
                    fallbackVideoKey: "Y274jZs5s7s"
                )
        
        ]
    }
}

// MARK: - Main View
// Main view for the New & Hot tab displaying trending and upcoming content
 // MARK: - Main View
    struct NewHotView: View {
       @State private var selectedTab = 0
       @StateObject private var contentService = NewHotContentService()
       
       var body: some View {
           VStack(spacing: 0) {
               // MARK: - Top Navigation Bar
               HStack {
                   Text("New & Hot")
                       .font(.title2)
                       .fontWeight(.bold)
                       .foregroundColor(.white)
                   
                   Spacer()
                   
                   // Navigation icons
                   HStack(spacing: 20) {
                       Button(action: {}) {
                           Image(systemName: "airplayvideo")
                               .foregroundColor(.white)
                               .font(.title3)
                       }
                       
                       Button(action: {}) {
                           Image(systemName: "arrow.down.circle")
                               .foregroundColor(.white)
                               .font(.title3)
                       }
                       
                       Button(action: {}) {
                           Image(systemName: "magnifyingglass")
                               .foregroundColor(.white)
                               .font(.title3)
                       }
                   }
               }
               .padding(.horizontal)
               .padding(.top, 60) // Increased from 20 to 60 - moves content down
               
               // MARK: - Tab Selector
               ScrollView(.horizontal, showsIndicators: false) {
                   HStack(spacing: 20) {
                       TabButton(title: "🍿 Coming Soon", isSelected: selectedTab == 0) {
                           selectedTab = 0
                       }
                       
                       TabButton(title: "🔥 Everyone's Watching", isSelected: selectedTab == 1) {
                           selectedTab = 1
                       }
                       
                       TabButton(title: "🎥 Top 10 TV Shows", isSelected: selectedTab == 2) {
                           selectedTab = 2
                       }
                       
                       TabButton(title: "🎬 Top 10 Movies", isSelected: selectedTab == 3) {
                           selectedTab = 3
                       }
                       Spacer()
                   }
                   .padding(.horizontal)
                   .padding(.vertical, 20) // Increased from 15 to 20
               }
               
               // MARK: - Content Section
               ScrollView(showsIndicators: false) {
                   LazyVStack(spacing: 20) {
                       switch selectedTab {
                       case 0:
                           ForEach(contentService.comingSoonContent) { item in
                               ComingSoonCard(item: item)
                           }
                       case 1:
                           ForEach(contentService.everyoneWatchingContent) { item in
                               EveryoneWatchingCard(item: item)
                           }
                       case 2:
                           ForEach(contentService.top10TVShows) { item in
                               Top10Card(item: item)
                           }
                       case 3:
                           ForEach(contentService.top10Movies) { item in
                               Top10Card(item: item)
                           }
                       default:
                           EmptyView()
                       }
                   }
                   .padding(.horizontal)
                   .padding(.top, 10) // Added top padding to content section
                   .padding(.bottom, 100)
               }
           }
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .background(Color.black)
           .ignoresSafeArea(.all)
           .onAppear {
               contentService.loadContent()
           }
       }
   }

// MARK: - Tab Button Component

// Custom tab button component for switching between Coming Soon and Everyone's Watching
struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: isSelected ? .semibold : .medium))
                .foregroundColor(isSelected ? .black : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color.white : Color.clear)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.5), lineWidth: isSelected ? 0 : 1)
                )
        }
    }
}

// MARK: - Coming Soon Card

// Card component for upcoming content with Remind Me functionality
struct ComingSoonCard: View {
    let item: NewHotItem
    @State private var isRemindMeSet = false
    @State private var isSpeakerSet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: - Video/Image Section
            ZStack(alignment: .bottomTrailing) {
                // Main content image with poster path
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay {
                        // Load image from URL (poster path) or fallback to title
                        AsyncImage(url: URL(string: item.imageURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                                .cornerRadius(10)
                        } placeholder: {
                            // Show loading indicator while image loads
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(height: 200)
                        }
                    }
                
                // Mute button overlay (video controls)
                Button(action: {
                    // TODO: Implement mute/unmute functionality
                    isSpeakerSet.toggle()
                }) {
                    Image(systemName: isSpeakerSet ? "speaker.wave.3" : "speaker.slash")
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(8)
                        .background(Circle().fill(Color.black.opacity(0.7)))
                }
                .padding(.trailing, 10)
                .padding(.bottom, 10)
            }
            
            // MARK: - Content Information
            VStack(alignment: .leading, spacing: 10) {
                // Content title
                Text(item.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // Content description
                Text(item.description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(nil) // Allow unlimited lines for full description
                
                // Remind Me action button
                Button(action: {
                    isRemindMeSet.toggle()
                }) {
                    HStack {
                        Image(systemName: isRemindMeSet ? "checkmark" : "bell")
                        Text(isRemindMeSet ? "Reminder Set" : "Remind Me")
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(6)
                }
            }
            .padding(.top, 15)
        }
        .padding(.vertical, 10)
    }
}


// MARK: - Everyone's Watching Card with Real Trailers

struct EveryoneWatchingCard: View {
    let item: NewHotItem
    @StateObject private var videoService = TMDBVideoService()
    @State private var finalVideoKey: String?
    @State private var isVideoReady = false
    @State private var isSpeakerSet = false
    @State private var showTrailer = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: - Video/Image Section
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 200)
                .overlay {
                    AsyncImage(url: URL(string: item.imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(height: 200)
                    }
                }
           
            // MARK: - Content Information and Actions
            VStack(alignment: .leading, spacing: 10) {
                Text(item.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(item.description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                
                // Action buttons row
               HStack(spacing: 16) {
                    
                    
                    // METHOD 2: If NavigationLink doesn't work, uncomment this and comment out the NavigationLink above
                    
                    Button(action: {
                        showTrailer = true
                        print("🎬 Opening trailer for: \(item.title)")
                        print("🎬 Video key: \(finalVideoKey ?? item.fallbackVideoKey ?? "none")")
                    }) {
                        playButtonLabel
                    }
                    .sheet(isPresented: $showTrailer) {
                        TrailerPlayerView(videoKey: finalVideoKey ?? item.fallbackVideoKey ?? "dQw4w9WgXcQ")
                    }
                    
                    
                    // METHOD 3: If both above don't work, uncomment this for fullScreenCover
                    /*
                    Button(action: {
                        showTrailer = true
                        print("🎬 Opening trailer for: \(item.title)")
                        print("🎬 Video key: \(finalVideoKey ?? item.fallbackVideoKey ?? "none")")
                    }) {
                        playButtonLabel
                    }
                    .fullScreenCover(isPresented: $showTrailer) {
                        TrailerPlayerView(videoKey: finalVideoKey ?? item.fallbackVideoKey ?? "dQw4w9WgXcQ")
                    }
                    */
                    
                    Button(action: {
                        // TODO: Add to My List action
                        print("👤 Add to My List tapped for: \(item.title)")
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("My List")
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 40)
                        .background(Color.gray.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(6)
                    }
                }
            }
            .padding(.top, 15)
        }
        .padding(.vertical, 10)
        .onAppear {
            loadTrailer()
        }
    }
    
    // Smart trailer loading: Try TMDB first, then fallback to specific trailer
    private func loadTrailer() {
        // First, set the fallback as ready
        finalVideoKey = item.fallbackVideoKey
        isVideoReady = true
        
        // Then try to get a better trailer from TMDB
        guard let tmdbId = item.tmdbId else { return }
        
        switch item.type {
        case .movie, .documentary:
            videoService.fetchMovieTrailer(movieId: tmdbId) { tmdbKey in
                if let tmdbKey = tmdbKey {
                    // Use TMDB trailer if found
                    self.finalVideoKey = tmdbKey
                    print(" Using TMDB trailer for \(item.title): \(tmdbKey)")
                } else {
                    // Keep using the specific fallback
                    print(" No TMDB trailer for \(item.title), using fallback: \(item.fallbackVideoKey ?? "none")")
                }
            }
        case .series:
            videoService.fetchTVTrailer(tvId: tmdbId) { tmdbKey in
                if let tmdbKey = tmdbKey {
                    // Use TMDB trailer if found
                    self.finalVideoKey = tmdbKey
                    print(" Using TMDB trailer for \(item.title): \(tmdbKey)")
                } else {
                    // Keep using the specific fallback
                    print(" No TMDB trailer for \(item.title), using fallback: \(item.fallbackVideoKey ?? "none")")
                }
            }
        }
    }
    // MARK: - Play Button Label (reusable)
    private var playButtonLabel: some View {
        HStack {
            if videoService.isLoading && !isVideoReady {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(0.8)
                Text("Loading...")
                    .font(.caption)
            } else {
                Image(systemName: "play.fill")
                Text("Play")
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 40)
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(6)
    }
}
    

// MARK: - Action Button Component

//Reusable action button component for various user actions
struct ActionButton: View {
    let icon: String
    let text: String
    let backgroundColor: Color
    let textColor: Color
    
    var body: some View {
        VStack(spacing: 5) {
            // Circular button with icon
            Button(action: {
                // TODO: Implement specific action based on button type
            }) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(textColor)
                    .frame(width: 35, height: 35)
                    .background(backgroundColor)
                    .cornerRadius(18)
            }
            
            // Button label
            Text(text)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
}



// MARK: - Top 10 Card Component
struct Top10Card: View {
    let item: Top10Item
    @StateObject private var videoService = TMDBVideoService()
    @State private var finalVideoKey: String?
    @State private var isVideoReady = false
    @State private var showTrailer = false // For sheet presentation
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Massive number that goes behind the image - side by side digits
            HStack(spacing: -10) {
                Text(String(format: "%02d", item.rank).prefix(1))
                    .font(.system(size: 110, weight: .black, design: .default))
                    .foregroundColor(.gray.opacity(0.3))
                   
                Text(String(format: "%02d", item.rank).suffix(1))
                    .font(.system(size: 110, weight: .black, design: .default))
                    .foregroundColor(.white)
            }
            .frame(width: 150, alignment: .leading)
        }
        .padding(.horizontal, -190)
        .padding(.bottom, -60)
        
        VStack(alignment: .leading, spacing: 0) {
            // MARK: - Video/Image Section
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 200)
                .overlay {
                    AsyncImage(url: URL(string: item.imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(height: 200)
                    }
                }
            
            // MARK: - Content Information and Actions
            VStack(alignment: .leading, spacing: 10) {
                Text(item.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(item.description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                
                // Action buttons row
                HStack(spacing: 16) {
                    
                    
                    // METHOD 2: If NavigationLink doesn't work, uncomment this and comment out the NavigationLink above
                    
                    Button(action: {
                        showTrailer = true
                        print("🎬 Opening trailer for: \(item.title)")
                        print("🎬 Video key: \(finalVideoKey ?? item.fallbackVideoKey ?? "none")")
                    }) {
                        playButtonLabel
                    }
                    .sheet(isPresented: $showTrailer) {
                        TrailerPlayerView(videoKey: finalVideoKey ?? item.fallbackVideoKey ?? "dQw4w9WgXcQ")
                    }
                    
                    
                    // METHOD 3: If both above don't work, uncomment this for fullScreenCover
                    /*
                    Button(action: {
                        showTrailer = true
                        print("🎬 Opening trailer for: \(item.title)")
                        print("🎬 Video key: \(finalVideoKey ?? item.fallbackVideoKey ?? "none")")
                    }) {
                        playButtonLabel
                    }
                    .fullScreenCover(isPresented: $showTrailer) {
                        TrailerPlayerView(videoKey: finalVideoKey ?? item.fallbackVideoKey ?? "dQw4w9WgXcQ")
                    }
                    */
                    
                    Button(action: {
                        // TODO: Add to My List action
                        print("👤 Add to My List tapped for: \(item.title)")
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("My List")
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 40)
                        .background(Color.gray.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(6)
                    }
                }
            }
            .padding(.top, 15)
        }
        .onAppear {
            loadTrailer()
        }
    }
    
    // MARK: - Play Button Label (reusable)
    private var playButtonLabel: some View {
        HStack {
            if videoService.isLoading && !isVideoReady {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(0.8)
                Text("Loading...")
                    .font(.caption)
            } else {
                Image(systemName: "play.fill")
                Text("Play")
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 40)
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(6)
    }
    
    // MARK: - Smart trailer loading
    private func loadTrailer() {
        // First, set the fallback as ready
        finalVideoKey = item.fallbackVideoKey
        isVideoReady = true
        
        print("🎬 Loading trailer for: \(item.title)")
        print("🎬 Fallback video key: \(item.fallbackVideoKey ?? "none")")
        
        // Then try to get a better trailer from TMDB
        guard let tmdbId = item.tmdbId else {
            print("🎬 No TMDB ID for \(item.title)")
            return
        }
        
        switch item.type {
        case .movie, .documentary:
            videoService.fetchMovieTrailer(movieId: tmdbId) { tmdbKey in
                if let tmdbKey = tmdbKey {
                    self.finalVideoKey = tmdbKey
                    print("✅ Using TMDB trailer for \(item.title): \(tmdbKey)")
                } else {
                    print("⚠️ No TMDB trailer for \(item.title), using fallback: \(item.fallbackVideoKey ?? "none")")
                }
            }
        case .series:
            videoService.fetchTVTrailer(tvId: tmdbId) { tmdbKey in
                if let tmdbKey = tmdbKey {
                    self.finalVideoKey = tmdbKey
                    print("✅ Using TMDB trailer for \(item.title): \(tmdbKey)")
                } else {
                    print("⚠️ No TMDB trailer for \(item.title), using fallback: \(item.fallbackVideoKey ?? "none")")
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NewHotView()
}

// LazyVStack - You’re displaying a long list of items.

// VStack - You have a small, fixed number of child views.
// Trending Now\n\n



